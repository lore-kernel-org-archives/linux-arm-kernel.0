From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 03 Sep 2012 14:21:44 +0200
Subject: [PATCH 4/6] ARM: Exynos4: Add OF compatibility lookups for Exynos4
 i2c adapters
In-Reply-To: <CAJuYYwT+diyXX0O2WOJ3=yFMJwEXLbb30rmcYfbomjaFEQmOuQ@mail.gmail.com>
References: <1346311903-15920-1-git-send-email-t.figa@samsung.com>
 <1346311903-15920-5-git-send-email-t.figa@samsung.com>
 <CAJuYYwT+diyXX0O2WOJ3=yFMJwEXLbb30rmcYfbomjaFEQmOuQ@mail.gmail.com>
Message-ID: <6770236.6s5UZoWZ6I@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Thanks for reviewing the patch.

On Friday 31 of August 2012 09:29:42 Thomas Abraham wrote:
> > +       OF_DEV_AUXDATA("samsung,s3c2440-i2c", EXYNOS4_PA_IIC(0),
> > +                               "s3c2440-i2c.0", NULL),
> 
> i2c0 lookup information is already in this list. So the above line
> should not be included in this patch.

Right, I must have overlooked it.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
