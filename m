From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Wed, 18 Dec 2013 03:15:10 +0000
Subject: [PATCH 3/3 v2] ARM: dts: sama5d3xcm: add the regulator device node
In-Reply-To: <20131217123818.GV3185@sirena.org.uk>
References: <1387258597-21866-1-git-send-email-wenyou.yang@atmel.com>
 <1387258597-21866-4-git-send-email-wenyou.yang@atmel.com>
 <20131217123818.GV3185@sirena.org.uk>
Message-ID: <B256D81BAE5131468A838E5D7A24364172F1839C@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: Tuesday, December 17, 2013 8:38 PM
> To: Yang, Wenyou
> Cc: lgirdwood at gmail.com; linux-kernel at vger.kernel.org;
> grant.likely at linaro.org; rob.herring at calxeda.com; linux-
> doc at vger.kernel.org; vpalatin at chromium.org; Ferre, Nicolas;
> plagnioj at jcrosoft.com; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH 3/3 v2] ARM: dts: sama5d3xcm: add the regulator
> device node
> 
> On Tue, Dec 17, 2013 at 01:36:37PM +0800, Wenyou Yang wrote:
> 
> > +						vcc_1v8_reg: DCDC_REG1 {
> > +							regulator-name = "DCDC_REG1";
> 
> The whole point of naming the regulators is to help users read kernel
> diagnostic output so the should normally be named after the supply in
> the schematic.  If you're using the name of the supply on the PMIC you
> can just omit it since that's the default anyway and it's not adding
> extra information.  Use something like VCC_1V8.
Thanks a lot.
Change regulator-name with VCC_1V8, VCC_1V2 ... which named after the supply in the schematic.


Best Regards,
Wenyou Yang
