package main

func main() {
  // 設定メソッドのプレフィックスを無視してソート
  // keep-sorted start ignore_prefixes=fs.setBoolFlag,fs.setIntFlag,fs.setStringFlag
  fs.setStringFlag("fluffy_rabbit", "white")
  fs.setBoolFlag("paws_with_cute_toebeans", true)
  fs.setIntFlag("pretty_whiskered_kitten", 6)
  fs.setBoolFlag("whiskered_adorable_dog", true)
  // keep-sorted end
}

