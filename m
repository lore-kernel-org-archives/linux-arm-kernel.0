From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 23 Aug 2012 18:45:19 +0900
Subject: [PATCH 1/2] ARM: S3C64XX: Update configuration for WM5102 module
 on Cragganmore
In-Reply-To: <20120813122359.GA13446@opensource.wolfsonmicro.com>
References: <1344535549-4371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <0db901cd76b4$7daf1730$790d4590$%kim@samsung.com>
 <20120810100713.GH24328@opensource.wolfsonmicro.com>
 <0eff01cd777f$4c9d1f90$e5d75eb0$%kim@samsung.com>
 <20120813122359.GA13446@opensource.wolfsonmicro.com>
Message-ID: <1d5901cd8114$023550f0$069ff2d0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Sat, Aug 11, 2012 at 02:08:09PM +0900, Kukjin Kim wrote:
> 
> > BTW, don't you need to enable your Cragganmore board in the defconfig?
> 
> Well, it doesn't really matter that much to us - it's more a question
> for whoever uses the defconfig.

Yeah, actually SoC defconfig in mainline doesn't cover _real_ requirements
for (mass) product. But I think, it's time we need to sort out the
defconfigs so that we could use them efficiently on product. BTW, if
enabling board in defconfig, at least, unexpected build breakages could be
detected by testing defconfig before merge for mainline...

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
