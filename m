From: aletes.xgr@gmail.com (Alexandre Pereira da Silva)
Date: Mon, 16 Jul 2012 10:29:10 -0300
Subject: linux-next: Tree for July 16 - Build failure
Message-ID: <CAAAP30FQYPzScZiQqoYz3_Dv4+7sN+f1VBpbF=AeuwJsi-U5sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am getting errors building lpc32xx defconfig on linux-next tree for
next-20120716 tag.

Here are the errors:
drivers/built-in.o: In function `of_clk_get':
drivers/clk/clkdev.c:42: undefined reference to `of_clk_get_from_provider'
make[1]: ** [vmlinux] Erro 1

Any suggestions?

Thanks.
