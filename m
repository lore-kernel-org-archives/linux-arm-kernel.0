From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Aug 2017 10:37:19 -0700
Subject: [PATCH v2 0/3] ARM: dts: omap: workarounds for Ethernet PHY
 strap on DRA71 and DRA72 EVMs
In-Reply-To: <ca0d0615-d813-d00b-e853-25df9a5c49b6@ti.com>
References: <cover.1502284400.git.nsekhar@ti.com>
 <ca0d0615-d813-d00b-e853-25df9a5c49b6@ti.com>
Message-ID: <20170810173718.GP8569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [170809 15:27]:
> On 08/09/2017 09:02 AM, Sekhar Nori wrote:
> > Here are some patches to overcome incorrect Ethernet PHY strap settings
> > on DRA72x EVM Rev C and DRA71 EVM. Both of these boards use TI's DP83867
> > PHY.
> > 
> > The incorrect PHY strap settings cause a voilation of PHY specification
> > and need to be worked around in software as documented in the commit
> > messages. But there is no known issue that these patches fix.
...

> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applying dts changes into omap-for-v4.14/fixes-not-urgent
and defconfig into omap-for-v4.14/defconfig.

Thanks,

Tony
