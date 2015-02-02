From: tony@atomide.com (Tony Lindgren)
Date: Mon, 2 Feb 2015 08:09:33 -0800
Subject: [PATCH 4/4] ARM: dts: Add minimal support for dm8168-evm
In-Reply-To: <CAALWOA-XVrC84=6Xt04m+QaBhweAcp2HVTH7v=QewtJmQLEaWA@mail.gmail.com>
References: <1421192272-20754-1-git-send-email-tony@atomide.com>
 <1421192272-20754-5-git-send-email-tony@atomide.com>
 <20150117164709.GS18552@atomide.com>
 <CAALWOA-XVrC84=6Xt04m+QaBhweAcp2HVTH7v=QewtJmQLEaWA@mail.gmail.com>
Message-ID: <20150202160932.GF16250@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [150131 17:54]:
> I just noticed the dm816x.dtsi says:
> 
> ocp {
>         compatible = "ti,omap3-l3-smx", "simple-bus";
> 
> This is incorrect: the DM81xx (and siblings like the AM335x) use
> Arteris FlexNOC for the L3 interconnect, same as omap4/5 and vayu, not
> SonicsMX. (In general everything on the DM81xx seems to be
> omap4-generation)

Good catch, yes it seems it's mostly omap4. Looks like we
should also add it for am33xx.dtsi while at it.

I'll also check the devices one more time if I have some as
compatible with omap3 instead of omap4.

Regards,

Tony
