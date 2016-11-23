From: tony@atomide.com (Tony Lindgren)
Date: Wed, 23 Nov 2016 08:10:49 -0800
Subject: [PATCH v2] ARM: dts: am335x-baltos: use phy-phandle declarations
In-Reply-To: <1479916166-6633-1-git-send-email-yegorslists@googlemail.com>
References: <1479916166-6633-1-git-send-email-yegorslists@googlemail.com>
Message-ID: <20161123161049.GH4082@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* yegorslists at googlemail.com <yegorslists@googlemail.com> [161123 07:49]:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> phy-phandle is now a preferred method to reference a PHY device.
> Especially in regards to cpsw it enables PHY specific settings like
> max-speed etc. being specified in DTS.

Applying into omap-for-v4.10/dt thanks.

Tony
