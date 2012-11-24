From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 24 Nov 2012 11:10:44 +0900
Subject: [PATCH V3 0/5] Avoid passing clks through platform data
In-Reply-To: <20121123115109.GH4529@opensource.wolfsonmicro.com>
References: <1352177317-16395-1-git-send-email-padma.v@samsung.com>
 <CAAgF-Bevg7h1yq1bnLhwbUJ94+HKhaaJ6MeYvXUAunKpE-Lvkw@mail.gmail.com>
 <20121123115109.GH4529@opensource.wolfsonmicro.com>
Message-ID: <122c01cdc9e8$e91ed500$bb5c7f00$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Fri, Nov 23, 2012 at 04:40:59PM +0530, Padma Venkat wrote:
> > cc'ing Mark Brown.
> >
> > On Tue, Nov 6, 2012 at 10:18 AM, Padmavathi Venna <padma.v@samsung.com>
> wrote:
> > > Changes since v2:
> > >         - Rebased on 3.7-rc3
> 
> Please don't do this, send the patches non-quoted.

And it can make a confusion if there is no any explanation...

Note, I applied following arch/arm/ Samsung stuff for audio with Sangbeom's
ack:-)

Padmavathi Venna (9):
      ARM: EXYNOS: Add clocks for EXYNOS5 Audio Subsystem
      ARM: dts: Add nodes for i2s controllers for Samsung EXYNOS5 platforms
      ARM: EXYNOS: Enable platform support for I2S controllers
      ARM: S3C64XX: Add I2S clkdev support
      ARM: S5PC100: Add I2S clkdev support
      ARM: S5P64X0: Add I2S clkdev support
      ARM: S5PV210: Avoid passing the clks through platform data
      ARM: EXYNOS: Avoid passing the clks through platform data
      ARM: SAMSUNG: Delete the unnecessary variable

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
