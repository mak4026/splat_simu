# Splatoonウデマエシミュレーター

S+のプレイヤー同士をたくさん戦わせて, そのあとウデマエがどうなってるかを見るプログラムです.
実行すると,

| カラム名 | 意味 |
|:----|:----|
| `udemae` | 最終ウデマエ値 |
| `player_skill` | そのプレイヤーの実力を表すパラメータ |
| `game_count` | 試合回数 |
| `dropout` | S落ち経験者かどうか |
| `counter_stop` | カンスト経験者かどうか |

を含むCSVデータを作ります. ファイルネームは`splasimuYYYY-MM-dd_HHmmss.csv`です.
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
