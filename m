From: tony@atomide.com (Tony Lindgren)
Date: Fri, 16 Oct 2015 07:57:07 -0700
Subject: [PATCH 3/3] ARM: dts: Add basic support for isee igepv5
In-Reply-To: <CAFqH_52T8rPJp-8+Bb7Tjv-kcACU8FJGtqFWOhj02DzQ2yc7nw@mail.gmail.com>
References: <1444756728-11185-1-git-send-email-tony@atomide.com>
 <1444756728-11185-3-git-send-email-tony@atomide.com>
 <CAFqH_52T8rPJp-8+Bb7Tjv-kcACU8FJGtqFWOhj02DzQ2yc7nw@mail.gmail.com>
Message-ID: <20151016145707.GU10113@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Enric Balletbo Serra <eballetbo@gmail.com> [151016 01:26]:
> Hi Tony,
> 
> Many thanks for the patch
> 
> 2015-10-13 19:18 GMT+02:00 Tony Lindgren <tony@atomide.com>:
> > With omap5-board-common.dtsi, we can now easily add support for various omap5
> > board variants. Let's add minimal support for isee igepv5.
> >
> > So far I've tested that basic things work, such as serial, USB Ethernet, HDMI
> > and WLAN.
> >
> > Note that like omap5-uevm, these boards seem to need to reserve 16MB for a
> > trap section as in commit 03178c66d289 ("ARM: dts: omap5-evm: Update
> > available memory to 2032 MB") and also noted in a u-boot commit at
> > http://marc.info/?l=u-boot&m=134376852603255 and also at
> > http://patchwork.ozlabs.org/patch/159881/.
> >
> > Not sure why this is not needed for omap5-cm-t54.dts, maybe because of
> > different u-boot configuration.
> >
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >
> > Enric, can you please check if there are some critical pieces compared
> > to omap5-uevm that should be updated for this patch?
> >
> 
> Unfortunately I don't have the schematic and any IGEPv5 to verify your
> patches. From a quick view I can say that it's ok but let me cc
> Agust?, Eduard and Pau that will have access to the hardware and the
> schematics.

OK thanks. The thing to do is check against the omap5-board-common.dtsi in
this patch series so there's nothing unsuitable in omap5-board-common.dtsi
that needs an override in omap5-igep0050.dts.

Regards,

Tony
