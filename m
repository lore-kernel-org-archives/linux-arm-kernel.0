From: tony@atomide.com (Tony Lindgren)
Date: Mon, 26 Mar 2018 08:37:14 -0700
Subject: Regression with arm in next with stack protector
In-Reply-To: <tencent_79FD53B203715FD7439C6EAB@qq.com>
References: <20180323181452.GJ5799@atomide.com>
 <CAOMZO5Bmpk4cwav-qTnNA6L16DwdDPp5LeKC-jY9=QzfVBuKSQ@mail.gmail.com>
 <20180323121530.f28dc29939d9395268911a4e@linux-foundation.org>
 <tencent_79FD53B203715FD7439C6EAB@qq.com>
Message-ID: <20180326153714.GG5700@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* ??? <chenhc@lemote.com> [180326 06:59]:
> Hi, Tony and Fabio,
> 
> Could you please upload your kernel binary to somewhere for me? I don't understand why some ARM boards is OK while others are broken.

Well the kernel I'm testing is just current Linux next cross
compiled omap2plus_defconfig kernel. I do have few more config
options enabled like LOCKDEP and DEBUG_ATOMIC_SLEEP, but I
doubt they matter here :)

Then I'm using gcc-7.3.0 and binutils-2.30 built with the
buildall.git scripts:

git://git.infradead.org/users/segher/buildall.git

If you still need binaries, let me know.

Do you know which arm devices are working with your patch?

Regards,

Tony
