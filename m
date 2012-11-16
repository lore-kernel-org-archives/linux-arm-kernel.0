From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Fri, 16 Nov 2012 20:28:40 +0300
Subject: s3c2410 (Linux 2.6.36) Incorrect DRAM size
In-Reply-To: <slrnkactau.29u.narkewoody@zuhnb712.local.com>
References: <slrnkactau.29u.narkewoody@zuhnb712.local.com>
Message-ID: <CA+E=qVe3=cCLuELB7tuHp2Qis6_2EL_Q_XgC+aUk4398HysPSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 8:19 PM, Woody Wu <narkewoody@gmail.com> wrote:
> Hi,
>
> I just buit a 2.6.36 and boot it from a s3c2410 board.  At the very
> beginning of consol log, the kernel reports the DRAM size if 16M.
> (Memory: 16M = 16M total).  But the board actually has 64M ram in two
> bands (each is 32M).
>
> Did someone know the cause and have a hint or solution? And, does anyone
> knows that the DRAM size is auto-detected by kernel or hard configured
> in some .h?

Bootloader passes ATAGs with memory location and size, so something's
wrong with your bootloader.

Regards
Vasily

> Thanks in advance
>
> --
> -woody
> I can't go back to yesterday - because I was a different person then.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
