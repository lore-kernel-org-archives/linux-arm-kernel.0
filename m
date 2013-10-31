From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 31 Oct 2013 10:21:23 +0100
Subject: [PATCH 1/2] ARM: kirkwood: add support for OpenBlocks A7 platform
In-Reply-To: <52722037.8050808@free-electrons.com>
References: <1383152110-19577-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1383152110-19577-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20131030195724.GI26784@titan.lakedaemon.net>
 <20131031093735.68aa7df1@skate>
 <52722037.8050808@free-electrons.com>
Message-ID: <20131031102123.5eff2255@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Thu, 31 Oct 2013 10:17:43 +0100, Gregory CLEMENT wrote:

> > Strange. 'make dtbs' was working here. What was wrong exactly? Just
> > that the unit address (@90000) didn't match the starting address
> > 0x1c0000 ?
> 
> The unit address has no special meaning for the device tree it's just a
> way to give a unique name to a node right?

Yes, that's also my understanding.

> So in this case it is not really a problem, but it's just nicer for the
> coherency of the information in the dt to have the unit address which match
> the starting address.

Indeed, it's much better if they match (shame on me for the silly
copy/paste), but having then *not* matching should not cause any DTC
error, I believe.

> I also do a make dtbs ans I didn't get any errors:
> $ make dtbs
>  [...]
>   DTC     arch/arm/boot/dts/kirkwood-openblocks_a6.dtb
>   DTC     arch/arm/boot/dts/kirkwood-openblocks_a7.dtb

Same here.

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
