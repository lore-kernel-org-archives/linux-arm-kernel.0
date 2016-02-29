From: tony@atomide.com (Tony Lindgren)
Date: Mon, 29 Feb 2016 15:01:46 -0800
Subject: [PATCH] ARM: dts: DRA7: change address-cells and size-cells
In-Reply-To: <1456308664-28308-1-git-send-email-lokeshvutla@ti.com>
References: <1456308664-28308-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <20160229230146.GT13417@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lokesh Vutla <lokeshvutla@ti.com> [160224 02:14]:
> DRA7 SoC has the capability to support DDR memory upto 4GB. In order to
> represent this in memory dt node, the address-cells and size cells
> should be 2. So, changing the address-cells and size-cells to 2 and
> updating the memory nodes accordingly.

Applying into omap-for-v4.6/dt thanks.

Tony
