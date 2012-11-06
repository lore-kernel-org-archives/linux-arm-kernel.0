From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 06 Nov 2012 19:59:14 +0900
Subject: [PATCH 6/7] pinctrl: exynos5440: add pinctrl driver for Samsung
 EXYNOS5440 SoC
In-Reply-To: <CACRpkdZP_sTKV1Nq3FWVQJocg8C8H7J9vd9hmY4k-qAnMPJcLg@mail.gmail.com>
References: <1351274153-3120-1-git-send-email-kgene.kim@samsung.com>
 <1351274153-3120-6-git-send-email-kgene.kim@samsung.com>
 <CACRpkdZP_sTKV1Nq3FWVQJocg8C8H7J9vd9hmY4k-qAnMPJcLg@mail.gmail.com>
Message-ID: <0be701cdbc0d$c29565e0$47c031a0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> 
> On Fri, Oct 26, 2012 at 7:55 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> 
> > From: Thomas Abraham <thomas.abraham@linaro.org>
> >
> > Add a new pinctrl driver for Samsung EXYNOS5440 SoC. The pin controller
> > module in EXYNOS5440 is different from the pin controller found on other
> > Samsung SoC. Hence, the pin controller driver for EXYNOS5440 SoC is
> > independent of the Samsung pinctrl framework.
> >
> > Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> 
> If I haven't ACK:ed this before here's an
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
Thanks for your ack.

> I expect this to go through the Samsung tree?
> 
Yeah, this would be sent to upstream via Samsung tree.

Let me pick this up in my tree with your ack.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
