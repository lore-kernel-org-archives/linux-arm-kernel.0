From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Jul 2017 00:17:28 -0700
Subject: [PATCH 0/2] mmc: omap: Remove Unused Code
In-Reply-To: <CAPDyKFqk1fnL_CFSfgg2P44-KD9H=6mvK6ppXoDe=Xy38ujiFA@mail.gmail.com>
References: <1500036404-5556-1-git-send-email-faiz_abbas@ti.com>
 <20170717060101.GB10026@atomide.com>
 <CAPDyKFqk1fnL_CFSfgg2P44-KD9H=6mvK6ppXoDe=Xy38ujiFA@mail.gmail.com>
Message-ID: <20170717071727.GF10026@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ulf Hansson <ulf.hansson@linaro.org> [170717 00:09]:
> On 17 July 2017 at 08:01, Tony Lindgren <tony@atomide.com> wrote:
> > * Faiz Abbas <faiz_abbas@ti.com> [170714 05:48]:
> >> This patch series removes some code in omap_hsmmc.c
> >> and hsmmc.c and members from hsmmc.h and
> >> hsmmc-omap.h which are not used anymore post
> >> conversion to device-tree.
> >
> > Hey that's nice! That gets us a bit closer removing the
> > old platform data for that driver.
> 
> Tony,
> 
> As it seems Kishon is working on some more omap_hsmmc changes, I
> wondering whether it's fine if I pick this series via my mmc tree. To
> avoid merge conflicts later on?

Yes please do and for both feel free to add:

Acked-by: Tony Lindgren <tony@atomide.com>

And if you want to be extra nice, please add these two directly
on v4.13-rc1 before merging them into your branch in case I need
to merge them in too for any unlikely SoC related conflicts.

Regards,

Tony
