From: chenhc@lemote.com (=?utf-8?B?6ZmI5Y2O5omN?=)
Date: Tue, 27 Mar 2018 16:29:12 +0800
Subject: Regression with arm in next with stack protector
In-Reply-To: <20180326153714.GG5700@atomide.com>
References: <20180323181452.GJ5799@atomide.com>
 <CAOMZO5Bmpk4cwav-qTnNA6L16DwdDPp5LeKC-jY9=QzfVBuKSQ@mail.gmail.com>
 <20180323121530.f28dc29939d9395268911a4e@linux-foundation.org>
 <tencent_79FD53B203715FD7439C6EAB@qq.com>
 <20180326153714.GG5700@atomide.com>
Message-ID: <tencent_1DDCF65B56759D1B570EF7DD@qq.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner devices are OK, Exynos devices (except 4210) are OK.
 
------------------ Original ------------------
From:  "Tony Lindgren"<tony@atomide.com>;
Date:  Mon, Mar 26, 2018 11:37 PM
To:  "???"<chenhc@lemote.com>;
Cc:  "Andrew Morton"<akpm@linux-foundation.org>; "Fabio Estevam"<festevam@gmail.com>; "Stephen Rothwell"<sfr@canb.auug.org.au>; "Rich Felker"<dalias@libc.org>; "Russell King"<linux@arm.linux.org.uk>; "Yoshinori Sato"<ysato@users.sourceforge.jp>; "linux-kernel"<linux-kernel@vger.kernel.org>; "Ralf Baechle"<ralf@linux-mips.org>; "linux-omap"<linux-omap@vger.kernel.org>; "James Hogan"<james.hogan@mips.com>; "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"<linux-arm-kernel@lists.infradead.org>;
Subject:  Re: Regression with arm in next with stack protector
 
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
