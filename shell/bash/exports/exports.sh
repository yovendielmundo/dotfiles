paths=(
    "/Users/luis/.rust/cargo/bin"
    "/usr/local/opt/mysql-client/bin"
    "/usr/local/opt/openjdk/bin"
    "/usr/local/bin"
    "/bin"
    "/usr/local/opt/gnu-sed/libexec/gnubin"
    "/usr/local/opt/make/libexec/gnubin"
    "/usr/bin"
    "/usr/local/sbin"
    "/usr/sbin"
    "/sbin"
)

PATH=$(
    IFS=":"
    echo "${paths[*]}"
)

export PATH


   
