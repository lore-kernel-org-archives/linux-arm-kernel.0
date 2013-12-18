From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Wed, 18 Dec 2013 03:12:34 +0000
Subject: [PATCH 2/3 v2] regulator: act8865: add device tree binding doc
In-Reply-To: <20131217124750.GX3185@sirena.org.uk>
References: <1387258597-21866-1-git-send-email-wenyou.yang@atmel.com>
 <1387258597-21866-3-git-send-email-wenyou.yang@atmel.com>
 <20131217124750.GX3185@sirena.org.uk>
Message-ID: <B256D81BAE5131468A838E5D7A24364172F1838F@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: Tuesday, December 17, 2013 8:48 PM
> To: Yang, Wenyou
> Cc: lgirdwood at gmail.com; linux-kernel at vger.kernel.org;
> grant.likely at linaro.org; rob.herring at calxeda.com; linux-
> doc at vger.kernel.org; vpalatin at chromium.org; Ferre, Nicolas;
> plagnioj at jcrosoft.com; linux-arm-kernel at lists.infradead.org;
> devicetree at vger.kernel.org
> Subject: Re: [PATCH 2/3 v2] regulator: act8865: add device tree binding
> doc
> 
> On Tue, Dec 17, 2013 at 01:36:36PM +0800, Wenyou Yang wrote:
> 
> > +Required properties:
> > +- compatible: "active-semi,act8865"
> > +- reg: I2C slave address
> 
> This needs to also document the regulators property, for example all the
> regulator names.
Add all the regulator name:
The valid names for regulators are:
       DCDC_REG1, DCDC_REG2, DCDC_REG3, LDO_REG1, LDO_REG2, LDO_REG3, LDO_REG4.

Best Regards,
Wenyou Yang
