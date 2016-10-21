From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 21 Oct 2016 12:25:14 +0300
Subject: [PATCH 2/3] ARM: bus: da8xx-syscfg: new driver
In-Reply-To: <7h8tti6c95.fsf@baylibre.com>
References: <1476721850-454-1-git-send-email-bgolaszewski@baylibre.com>
 <2278105.geKhb8xoNC@avalon> <7h8ttj6jqo.fsf@baylibre.com>
 <1867292.F3aGJTmS2t@avalon> <7h8tti6c95.fsf@baylibre.com>
Message-ID: <f6a0f61e-9d78-3df1-8e41-435eb47a1f00@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/10/16 22:39, Kevin Hilman wrote:

> However, after our discussion on IRC, we'll respin this without the DT
> bindings at all.  Next version will just use static configuration data
> in the drivers/bus driver based on SoC compatible string, since for the
> use-cases I'm aware of, the settings are boot-time only.

If it's static boot time config, why not do it in the u-boot?

I'm fine either way, but this sounds like quite low level memory bus config.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161021/09458b88/attachment.sig>
