From: tony@atomide.com (Tony Lindgren)
Date: Wed, 22 Jun 2016 21:49:18 -0700
Subject: [PATCHv2 00/27] crypto: fixes for omap family of devices
In-Reply-To: <1466601840-18486-1-git-send-email-t-kristo@ti.com>
References: <1466601840-18486-1-git-send-email-t-kristo@ti.com>
Message-ID: <20160623044917.GL22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [160622 06:27]:
> Hi,
> 
> Changes compared to v1 of the series:
> 
> - dropped first patch from the series (crypto: omap-aes: Fix registration of
>   algorithms) as it was queued by Herbert already
> - modified the second (now first) patch of the series to use runtime auto-
>   suspend instead of getting static sync over a cra lifetime
> - re-ordered the DTS / hwmod changes in the series, the merge order of
>   these must be maintained to avoid issues
> 
> Patches #01 .. #14 should be merged via crypto tree, the rest should be
> handled by Tony.

Next time, please post sets like these split into three separate sets
with the cover letter listing possible dependencies. Picking patches
from sets in certain order is a big pain to follow up, and some
maintainers tend to ignore patchsets with dependencies.

> Merging the omap / dts parts can be done safely separately, assuming
> you just use omap2plus_defconfig (enabling crypto features will
> cause some issues without the driver level fixes.)

I've already applied the dts changes I believe.. So reposting already
applied patches further confuses things. Now I have to figure out what
is already applied..

Regards,

Tony
