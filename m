From: andi@etezian.org (Andi Shyti)
Date: Sun, 19 Jun 2016 14:59:21 +0900
Subject: [PATCH] clk: samsung: exynos5433: use clock_ignore_unused flag
 for SPI3 related clocks
In-Reply-To: <CA+Ln22F9eskcpnFkrnVFc3dJqCJcJ5O-STfXC-8Om5MK-THwNg@mail.gmail.com>
References: <1466151362-2881-1-git-send-email-andi.shyti@samsung.com>
 <CA+Ln22F9eskcpnFkrnVFc3dJqCJcJ5O-STfXC-8Om5MK-THwNg@mail.gmail.com>
Message-ID: <20160619055921.GA424@jack.zhora.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

> > The SPI 3 bus uses two clocks, a bus clock and an input clock.
> > Do not disable the clocks when unused in order to allow access to
> > the SPI 3 device.
> 
> If unused, why would access to SPI 3 device needed?

because next I will submit a small driver which uses the SPI3.
Actually in the exynos5433 boards all the SPI are used but not all
the drivers are ported to mainline.

Thanks,
Andi
