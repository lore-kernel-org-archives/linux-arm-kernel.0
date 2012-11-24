From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 24 Nov 2012 11:10:39 +0900
Subject: [PATCH V3] ARM: EXYNOS5: Add clocks for EXYNOS5 Audio Subsystem.
In-Reply-To: <000401cdc95c$c2aec420$480c4c60$@com>
References: <1352176731-16199-1-git-send-email-padma.v@samsung.com>
 <000401cdc95c$c2aec420$480c4c60$@com>
Message-ID: <122b01cdc9e8$e6287860$b2796920$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sangbeom Kim wrote:
> 
> On Tue, Nov 6, 2012 at 1:39 PM, Padmavathi Venna wrote:
> 
> > -----Original Message-----
> > From: Padmavathi Venna [mailto:padma.v at samsung.com]
> > Sent: Tuesday, November 06, 2012 1:39 PM
> > To: linux-arm-kernel at lists.infradead.org; linux-samsung-
> soc at vger.kernel.org
> > Cc: padma.v at samsung.com; sbkim73 at samsung.com; ben-linux at fluff.org;
> kgene.kim at samsung.com;
> > olofj at google.com
> > Subject: [PATCH V3] ARM: EXYNOS5: Add clocks for EXYNOS5 Audio
Subsystem.
> >
> > This patch adds all the required clock instances for audio
> > subsystem and adds the clock alias names for sclk-i2s and
> > i2s-bus clks. This patch also do the static mapping
> > of audss clock base address to control audss clocks in CMU
> > clock framework.
> >
> > Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> 
> Acked-by: Sangbeom Kim <sbkim73@samsung.com>
> 
Applied, thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
