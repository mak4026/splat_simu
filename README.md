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
あとはExcelやRで好き勝手に眺めるといいと思います.

## 使い方
```bash
bundle install
```
してから
```bash
ruby udemae_simu.rb -n 10000
```

### オプション引数
- `-n (int)` 参加するプレイヤーの人数
- `-r (int)` 対戦記録を記録するプレイヤーを配置します. 引数で記録プレイヤーのプレイヤースキル値を指定します. (ただし0 < r < 100)
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

