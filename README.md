# Splatoonウデマエシミュレーター

S+のプレイヤー同士をたくさん戦わせて, そのあとウデマエがどうなってるかを見るプログラムです.
実行すると,

| カラム名 | 意味 |
|:----|:----|
| `udemae` | 最終ウデマエ値 |
| `player_skill` | そのプレイヤーの実力を表すパラメータ |
| `game_count` | 試合回数 |
| `win_count` | 勝利回数 |
| `dropout` | S落ち経験者かどうか |
| `counter_stop` | カンスト経験者かどうか |

を含むCSVデータを作ります. ファイルネームは`splasimuYYYY-MM-dd_HHmmss[_id].csv`です.
また, `splasimuYYYY-MM-dd_HHmmss.log`に実行時に指定したオプションを記録します.
あとはExcelやRで好き勝手に眺めるといいと思います.

## 使い方
```bash
bundle install
```
してから
```bash
ruby udemae_simu.rb -n 10000
```

## シミュレーションの流れ
1. 全プレイヤーを適当にマッチングさせる
1. それぞれの部屋について勝敗を判定する
1. 勝敗に応じて, それぞれのプレイヤーのウデマエ値を変動させる.
1. 1.に戻る.

## 勝ち負けの決め方
基本的には, それぞれのチームのプレイヤーの`player_skill`の合計値を比較し, 多いほうが勝つというモデルです.
例:
>
- アルファチーム: 10, 20, 30, 80 → `player_skill`の総和 = 140
- ブラボーチーム: 20, 30, 60, 60 → `player_skill`の総和 = 170
アルファ < ブラボー なのでブラボーの勝ち

### オプション引数
- `-n (int)` 参加するプレイヤーの人数
- `-r (int)` 対戦記録を記録するプレイヤーを配置します. 引数で記録プレイヤーのプレイヤースキル値を指定します. (ただし0 < `r` < 100)
対戦記録を次のような形のcsvで出力します.1行が1試合を表します.
ファイル名のidは"Record"です.
// jsonで出力したいかもしれない

| カラム名 | 意味 |
|:----|:----|
| `udemae` | その試合終了後のウデマエ値 |
| `result` | その試合の結果(`"win"`か`"lose"`) |
| `my_ps` | 記録しているプレイヤーの`player_skill` |
| `friend1` | 味方チームプレイヤーの`player_skill` |
| `friend2` | 味方チームプレイヤーの`player_skill` |
| `friend3` | 味方チームプレイヤーの`player_skill` |
| `rival1` | 敵チームプレイヤーの`player_skill` |
| `rival2` | 敵チームプレイヤーの`player_skill` |
| `rival3` | 敵チームプレイヤーの`player_skill` |
| `rival4` | 敵チームプレイヤーの`player_skill` |
| `reason` | 試合結果の決定理由(後述) |

例:
```csv
53,win,50,67,52,39,60,52,18,73,""
```

- `--random (float)` 指定すると対戦結果が指定された確率でランダム（1:1）に決定されます.  (0 <= `random` <= 1)
例えば, 編成事故や回線落ちの場合を想定しています.
このオプションの指定により, 試合結果がランダムに決定された試合は, `-r`オプションで生成される対戦記録のcsvの`reason`カラムに`"random"`が格納されます.
```csv
60,lose,50,60,39,52,67,52,73,18,random
```
