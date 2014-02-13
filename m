From: tony@atomide.com (Tony Lindgren)
Date: Thu, 13 Feb 2014 15:22:49 -0800
Subject: [PATCH 1/2] ARM: dts: N9/N950: fix boot hang with 3.14-rc1
In-Reply-To: <52FA83DE.70504@ti.com>
References: <1391947956-24462-1-git-send-email-aaro.koskinen@iki.fi>
 <52FA83DE.70504@ti.com>
Message-ID: <20140213232249.GQ28216@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [140211 12:13]:
> On 02/09/2014 06:12 AM, Aaro Koskinen wrote:
> > N9/N950 does not boot anymore with 3.14-rc1, because SoC compatible
> > property is missing. Fix that.
> > 
> > Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> 
> Reviewed-by: Nishanth Menon <nm@ti.com>

Applying both into omap-for-v3.14/fixes thanks.

Tony
