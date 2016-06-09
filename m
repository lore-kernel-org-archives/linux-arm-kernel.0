From: tony@atomide.com (Tony Lindgren)
Date: Thu, 9 Jun 2016 00:19:30 -0700
Subject: [PATCH] ARM: dts: DRA74x: fix DSS PLL2 addresses
In-Reply-To: <57566A4A.4020102@ti.com>
References: <1463739213-31540-1-git-send-email-tomi.valkeinen@ti.com>
 <57566A4A.4020102@ti.com>
Message-ID: <20160609071930.GL22406@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [160606 23:34]:
> On 20/05/16 13:13, Tomi Valkeinen wrote:
> > DSS's 'pll2_clkctrl' and 'pll2' have wrong addresses in the dra74x.dtsi
> > file. Video PLL2 has not been used so wrong addresses went unnoticed.
...
> Ping on this.

Applying into omap-for-v4.7/fixes finally thanks.

Tony
