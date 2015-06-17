From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 17 Jun 2015 10:21:40 +0200
Subject: [PATCH 2/2] pinctrl: rockchip: add support for the rk3368
In-Reply-To: <6672678.KPGUcFJOAs@diego>
References: <2322857.kblfsanYOB@diego>
	<6672678.KPGUcFJOAs@diego>
Message-ID: <CACRpkdYm0XL1w_5VnaaXjnt7gR=RtO0w=Q4kVdsJNH6o+12fOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 12, 2015 at 11:51 PM, Heiko St?bner <heiko@sntech.de> wrote:

> The rk3368 is the first ARM64 soc from Rockchip, but seems to share most
> peripherals with the ARM32 soc, including the pinctrl functionality.
> The only notable difference is - as with every Rockchip soc - that the
> offsets in the General Register Files moved around and a split of the pmu
> section of the rk3288 into pmu and pmugrf (pmu general register files)
> sections. The pinctrl driver of course only needs the pmugrf registers
> for controlling the pin settings.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Patch applied.

Yours,
Linus Walleij
