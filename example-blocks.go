package main

type Widget struct {
  Name string
}

func main() {
  widgets := []Widget{
    // keep-sorted start block=yes
    {
      Name: "abc",
    },
    {
      Name: "def",
    },
    {
      Name: "xyz",
    },
    // keep-sorted end
  }
}
