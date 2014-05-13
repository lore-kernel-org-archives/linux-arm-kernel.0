From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 13 May 2014 14:32:08 +0900
Subject: [PATCH v2 0/4] ARM: S3C24XX: cleanup debug macro/earlyprintk
In-Reply-To: <2586347.kOddnpvo1Z@diego>
References: <1856986.kkQFKFg1L2@phil>
 <0cc401cf68e1$eb87f580$c297e080$@samsung.com> <2586347.kOddnpvo1Z@diego>
Message-ID: <074701cf6e6c$aeabc610$0c035230$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 

[...]

> > >
> > > Heiko Stuebner (4):
> > >   ARM: compressed/head.S: remove s3c24xx special case
> > >   ARM: S3C24XX: trim down debug uart handling
> > >   ARM: S3C24XX: use generic DEBUG_UART_PHY/_VIRT in debug macro
> > >   ARM: S3C24XX: move debug-macro.S into the common space
> > >
> > >  arch/arm/Kconfig.debug                           |  54 +++++++++++-
> > >  arch/arm/boot/compressed/head.S                  |   5 --
> > >  arch/arm/include/debug/s3c24xx.S                 |  46 +++++++++++
> > >  arch/arm/mach-s3c24xx/Kconfig                    |  28 -------
> > >  arch/arm/mach-s3c24xx/include/mach/debug-macro.S | 101 --------------
> ----
> > >
> > > -----
> > >
> > >  5 files changed, 98 insertions(+), 136 deletions(-)
> > >  create mode 100644 arch/arm/include/debug/s3c24xx.S
> > >  delete mode 100644 arch/arm/mach-s3c24xx/include/mach/debug-macro.S
> > >
> > > --
> > > 1.9.0
> >
> > Basically I'm OK on this series but need to get review from Russell?
> 
> Russell pointed out a bad decision on my part in v1, so I guess he is
> aware of
> this series :-) . I've also added arm at kernel.org now, so they can
complain,
> if
> anything is done wrong [should've probably done that from the beginning].
> 
OK, I will apply this series.

Russell, do you have any comments on this series, please kindly let us know.

Thanks,
Kukjin
