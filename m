From: linux@roeck-us.net (Guenter Roeck)
Date: Fri, 13 Jul 2012 07:41:38 -0700
Subject: [PATCH 0/2] ARM: exynos: Enable TMU support in exynos platforms
In-Reply-To: <117e01cd60ea$99f24e60$cdd6eb20$%kim@samsung.com>
References: <1342084543-8302-1-git-send-email-amit.daniel@samsung.com>
 <117e01cd60ea$99f24e60$cdd6eb20$%kim@samsung.com>
Message-ID: <20120713144138.GB25264@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 08:28:18PM +0900, Kukjin Kim wrote:
> Amit Daniel Kachhap wrote:
> > 
> > These TMU enablement patches are needed for exynos4 and exynos5 TMU
> > driver patches sent earlier. The link for those are
> > http://www.spinics.net/lists/lm-sensors/msg35858.html.
> > 
> How was going on above patches? I can't see them you said in linux-next now,
> it means if I apply this series in my tree, problem will be happened :(
> 
> Note1: I've seen Rafael's updating exynos4_tmu patch which is using struct
> dev_pm_ops for pm and applied by Guenter.
> 
If that is in the way, I can drop it, to be applied after the move. Let me know.
There is now another patch pending, to convert the driver to use devm_ functions.
Please let me know what you want me to do with it.

> Note2: would be helpful if you could do adding me in Cc of exynos tmu
> patches...
> 
If you want to be copied, it might make sense to add yourself as maintainer for
this file. Otherwise you can not expect people to know.

Thanks,
Guenter
