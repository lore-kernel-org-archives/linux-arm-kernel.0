From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 08 Dec 2011 10:47:40 +0900
Subject: [PATCH] ARM: S3C64XX: Hook up VDDINT on Cragganmore
In-Reply-To: <20111206102732.GE28840@opensource.wolfsonmicro.com>
References: <1323105817-5638-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CAH9JG2V8jJGeTDUZjcXa4hs67SaivocO4g-+wB=2+zv2FwsGyQ@mail.gmail.com>
 <20111206102732.GE28840@opensource.wolfsonmicro.com>
Message-ID: <04ca01ccb54b$5ed1e390$1c75aab0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Tue, Dec 06, 2011 at 08:21:30AM +0900, Kyungmin Park wrote:
> 
> > > +	REGULATOR_SUPPLY("vddint", NULL),
> 
> > Now there's mixed usage for vddint. until s5pc110 it uses the 'vddint'
> > but after exynos it uses the 'vdd_int'. either is okay but need to use
> > the same name for consistency?
> 
> > How do you think?
> 
> I don't really care either way.  I called it vddint because the existing
> s3c64xx ARM core supply is called vddarm by software so I was also going
> for consistency here :) .  If we want to ensure consistency we should
> just pick something and move to it, though I don't know if it's really
> worth the effort.

Yes, I think so. If required, let's move it later.

Looks ok to me, will apply.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
