From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 20 Jul 2011 21:23:26 +0900
Subject: [PATCH v3 1/6] Samsung SoC ADC: use regulator (VDD for ADC).
In-Reply-To: <20110719154003.GK9652@opensource.wolfsonmicro.com>
References: <1309420175-10301-1-git-send-email-myungjoo.ham@samsung.com>
	<1309420175-10301-2-git-send-email-myungjoo.ham@samsung.com>
	<201106301122.50800.anarsoul@gmail.com>
	<20110630160501.GG3249@opensource.wolfsonmicro.com>
	<037301cc4376$3d7f5a20$b87e0e60$%kim@samsung.com>
	<20110719154003.GK9652@opensource.wolfsonmicro.com>
Message-ID: <069501cc46d7$d355f2c0$7a01d840$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Sat, Jul 16, 2011 at 02:07:13PM +0900, Kukjin Kim wrote:
> > Mark Brown wrote:
> 
> > > If there isn't a separate supply for the regulators on S3C24xx devices
> > > then I guess the best option is to provide that supply as a dummy
> > > regulator in the s3c24xx core code.
> 
> > OK, but it means I can't apply this until adding a dummy regulator for
> > S3C24XX?
> 
> That could always come later as a bug fix :)  The regulator API does
> have a couple of methods of substituting in a dummy regulator itself,
> though it does complain a bit, so it should mostly be a simple config
> change to work around on affected systems.

OK, I agree with your opinions.

Thanks :)

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
