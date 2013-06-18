From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 18 Jun 2013 19:58:27 +0900
Subject: [PATCH 0/2] Enable config options to enable S2R wakeup
In-Reply-To: <20130617172506.GD28497@quad.lixom.net>
References: <1371442686-24999-1-git-send-email-tushar.behera@linaro.org>
 <20130617172506.GD28497@quad.lixom.net>
Message-ID: <1c3201ce6c12$c2c9f6b0$485de410$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> On Mon, Jun 17, 2013 at 09:48:04AM +0530, Tushar Behera wrote:
> > RTC source is very useful in testing S2R wakeup. Also enable
> > gpio-keys driver in case someone wants wakeup the board using
> > the buttons.
> >
> > S2R wakeup feature on Arndale depends on following two additional
> > patches.
> >
> > 1. [PATCH 1/8] ARM: EXYNOS: use generic cpu idle function for wfi
> >  http://permalink.gmane.org/gmane.linux.linaro.devel/15871
> >
> > 2. [PATCH V2] ARM: dts: Enable RTC node for Arndale
> > (Posted a couple of minutes back, link not available yet)
> >
> > S2R wakeup tested on Arndale board with an initramfs through
> > both RTC wakeup alarm and GPIO button interrupt.
> >
> > Tushar Behera (2):
> >   ARM: exynos_defconfig: Enable GPIO buttons driver
> >   ARM: exynos_defconfig: Enable RTC driver
> >
> >  arch/arm/configs/exynos_defconfig |    3 +++
> >  1 file changed, 3 insertions(+)
> 
> Acked-by: Olof Johansson <olof@lixom.net>
> 
> ..  but I don't see a need to keep them as two separate commit, just
> squash
> them when applying, Kukjin.
> 
Sure, I will. Thanks.
- Kukjin
