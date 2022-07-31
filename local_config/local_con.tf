resource "local_file" "test"{
    content = "my first terraform code to write the file with given content"
    filename = "./test.txt"
}
