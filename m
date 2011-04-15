From: liu.h.jason@gmail.com (Jason Liu)
Date: Fri, 15 Apr 2011 11:37:28 +0800
Subject: About enable L2 cache in Linux kernel
Message-ID: <BANLkTinTB=BmybmAGCRAbS9+nsLbXwBvkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Russell,

I notice that if bootloader does not enable L2, after linux boot up,
the L2 cached will keep disabled.
Do you know why Linux kernel does not do L2 cache enable operation at
start up on cortex_a8?
Just due to that L2 is implementation specific? But cortex_a8
processor embed L2 cache inside.


BR,
Jason
