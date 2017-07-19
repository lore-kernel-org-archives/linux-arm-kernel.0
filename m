From: balbi@kernel.org (Felipe Balbi)
Date: Wed, 19 Jul 2017 21:13:29 +0300
Subject: USB 3.0 is broken on Odroid Xu4 on latest kernel
In-Reply-To: <CANAwSgSoo7g=RN4wQ96+NJRYZYy2WeHwPA-xJ2JY7yt25irDfA@mail.gmail.com>
References: <CANAwSgSoo7g=RN4wQ96+NJRYZYy2WeHwPA-xJ2JY7yt25irDfA@mail.gmail.com>
Message-ID: <87zic0b8hi.fsf@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Anand Moon <linux.amoon@gmail.com> writes:
> Hi Krzysztof,
>
> Today I tried to compile the latest kernel for Odroid xu4.
> using exynos_defconfig I build and loaded the kernel.
> but to my surprise usb 3.0 device and missing.
>
> odroid login: root
> Password:
> Last login: Wed Jul 19 14:01:44 UTC 2017 on ttySAC2
> Welcome to Ubuntu 16.04.2 LTS (GNU/Linux 4.13.0-rc1-xu4ml-27846-g74cbd96 armv7l)

Dude, you have 27 thousand patches on top of v4.13-rc1??? Try vanilla
v4.13-rc1 and try a git bisect.

-- 
balbi
