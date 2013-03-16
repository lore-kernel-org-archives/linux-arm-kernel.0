From: anilk4.v@gmail.com (Anil Kumar)
Date: Sat, 16 Mar 2013 10:14:09 +0530
Subject: Getting kernel uImage build issue on omap2+
Message-ID: <CABYxbz6ydTtHmLW1xETanHa9uZzZ5M=4wv3Wj5aNDE2Db1b2Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am getting kernel uImage build issue on omap2+ log[1]

Taken kernel branch "for_3.10/dts" from
https://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git

Taking reference from
https://kernel.googlesource.com/pub/scm/linux/kernel/git/tmlind/linux-omap/+/omap-for-v3.9/multiplatform-enable-signed-v2

Am I missing some thing ?

[1]
anil at anil-laptop:~/Anil/omap3/bcousson$  mkimage -A arm -O linux -T
kernel -C none -a 0x80008000 -e 0x80008000 -n "Linux" -d
zImage-omap2plus uImage-omap2plus
mkimage: Can't open zImage-omap2plus: No such file or directory
anil at anil-laptop:~/Anil/omap3/bcousson$

Thanks,
Anil
