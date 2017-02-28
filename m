From: tony@atomide.com (Tony Lindgren)
Date: Tue, 28 Feb 2017 08:37:34 -0800
Subject: [PATCH] ARM: dts: am57xx-idk: tpic2810 is on I2C bus, not SPI
In-Reply-To: <504d1a9f-8c89-43b2-9a49-f130a21c50fd@ti.com>
References: <f884c250c4142ef44ec0c770aab277803f1f5da3.1487171304.git.nsekhar@ti.com>
 <504d1a9f-8c89-43b2-9a49-f130a21c50fd@ti.com>
Message-ID: <20170228163733.GT21809@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andrew F. Davis <afd@ti.com> [170215 07:43]:
> On 02/15/2017 09:12 AM, Sekhar Nori wrote:
> > commit 50e95b6b854c ("ARM: dts: am57xx-idk: Add Industrial
> > output support") added the TPIC2810 device-tree node under
> > SPI bus instead of I2C1.
> > 
> 
> Well that's odd, looks like git could get confused by the lack of
> context around the node during rebases. Anyway,
> 
> Acked-by: Andrew F. Davis <afd@ti.com>

Applying into omap-for-v4.11/fixes thanks.

Tony
