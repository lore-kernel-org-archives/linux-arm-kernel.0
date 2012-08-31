From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 1 Sep 2012 00:46:50 +0200
Subject: [PATCH 0/3] ARM: EXYNOS: Add support for GPIO on Exynos4x12
In-Reply-To: <CAJuYYwTBeCczF7M=9pJzYUgGB3Xg1md2kRDKbYEU-ji-C1_hug@mail.gmail.com>
References: <4648723.rWnut7F0uJ@amdc1227>
 <CAJuYYwTBeCczF7M=9pJzYUgGB3Xg1md2kRDKbYEU-ji-C1_hug@mail.gmail.com>
Message-ID: <CACRpkdaMqvQOUETPKFuzBw1bW+GciHLE1uvtdkPV5FoxrowftQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2012 at 4:58 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> On 28 August 2012 15:31, Tomasz Figa <t.figa@samsung.com> wrote:

>> This patch series makes necessary preparations and adds support for GPIO on
>> Exynos4x12 SoCs.
>
> Hopefully, we can get device tree support merged for Exynos4412 soon
> and then switch over to using pinctrl driver. That can simplfy the
> gpio/pinmux support for Exynos4 SoC's.

This sounds like a NACK.

I will not merge these patches until Ben or Kukjin (the Samsung
maintainers listed in MAINTAINERS) ACK it.

Yours,
Linus Walleij
