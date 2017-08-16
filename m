From: tony@atomide.com (Tony Lindgren)
Date: Wed, 16 Aug 2017 08:23:44 -0700
Subject: [PATCH] ARM: dts: am57xx-beagle-x15: Add support for rev C
In-Reply-To: <CAOCHtYi=JxMirp03DMny+HFo3g9nsPO--VuNK7N-YtctNhj2dg@mail.gmail.com>
References: <20170814175820.12065-1-robertcnelson@gmail.com>
 <bf2a5868-4c0b-58a1-350e-cba7dcfb5166@ti.com>
 <CAOCHtYi=JxMirp03DMny+HFo3g9nsPO--VuNK7N-YtctNhj2dg@mail.gmail.com>
Message-ID: <20170816152343.GG8569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Robert Nelson <robertcnelson@gmail.com> [170816 07:23]:
> and this is going to conflict with:
> 
> [v2,04/10] ARM: dts: am57xx-beagle-x15: Add pinmux configuration for MMC
> 
> https://patchwork.kernel.org/patch/9903875/
> 
> i'll wait for Tony to pick up Kishon's before i re-submit..

OK Kishon's patches are now all applied and merged into
my for-next branch I just pushed out. Can you please
update and test against that and repost?

The commit to use as base is commit 271df663be9e ("Merge branch
'omap-for-v4.14/dt-v3' into for-next") as that has -rc4 merged
in that has commit c5b3955828ba ("ARM: OMAP4: Fix legacy code
clean-up regression") while omap-for-v4.14/dt-v3 is missing that
for testing.

Regards,

Tony
