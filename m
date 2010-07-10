From: coffbeta@gmail.com (CoffBeta)
Date: Sat, 10 Jul 2010 14:01:19 +0800
Subject: TQ2440 problem
Message-ID: <AANLkTimQ62x7qhzNj2WDsi6D6XI-H1ayXx4-Hd6dg6Yt@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CHK     include/linux/compile.h
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
init/built-in.o: In function `do_one_initcall':
/home/ymcheng/linux-2.6.27/init/main.c:704: undefined reference to
`__gnu_mcount_nc'
init/built-in.o: In function `init_post':
/home/ymcheng/linux-2.6.27/init/main.c:796: undefined reference to
`__gnu_mcount_nc'
init/built-in.o: In function `name_to_dev_t':
/home/ymcheng/linux-2.6.27/init/do_mounts.c:76: undefined reference to
`__gnu_mcount_nc'
init/built-in.o: In function `set_reset_devices':
/home/ymcheng/linux-2.6.27/init/main.c:183: undefined reference to
`__gnu_mcount_nc'
init/built-in.o: In function `debug_kernel':
/home/ymcheng/linux-2.6.27/init/main.c:234: undefined reference to
`__gnu_mcount_nc'
init/built-in.o:/home/ymcheng/linux-2.6.27/init/main.c:240: more undefined
references to `__gnu_mcount_nc' follow
make: *** [.tmp_vmlinux1] ?? 1

why????how can I do it? thanks
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100710/2a253192/attachment.html>
