From: olof@lixom.net (Olof Johansson)
Date: Fri, 11 May 2012 00:21:52 -0700
Subject: [GIT PULL 1/10] omap non-critical fixes for v3.5 merge window
In-Reply-To: <4fac0be2.e9a0320a.1f37.7e70SMTPIN_ADDED@mx.google.com>
References: <4fac0be2.e9a0320a.1f37.7e70SMTPIN_ADDED@mx.google.com>
Message-ID: <CAOesGMi0+fty-x1kq0qo+msya=p5xyQDsB9iFrtht38Rn5V=Eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

I've pulled all 10 requests. Many of them ended up going into the same
next/ branch, but that's quite OK. Please double check my merge
conflict resolutions.

One nit is that at least one of the branches had a few varying patch
subjects, so just a friendly reminder to sanitize them to ARM: OMAP.*:
or so when you apply patches.

I did notice that omap2plus_defconfig has grown a new warning caused
by "ARM: OMAP2+: clean up some cppcheck warnings" (oh, the irony!):

arch/arm/plat-omap/usb.c: In function 'omap_otg_init':
arch/arm/plat-omap/usb.c:40:6: warning: unused variable 'status'
[-Wunused-variable]


-Olof
