From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 06 Dec 2017 11:52:44 -0800
Subject: [PATCH v5 0/2] meson: saradc: drop the sana clock
In-Reply-To: <20171116090115.29915-1-yixun.lan@amlogic.com> (Yixun Lan's
 message of "Thu, 16 Nov 2017 17:01:13 +0800")
References: <20171116090115.29915-1-yixun.lan@amlogic.com>
Message-ID: <7h609jskfn.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yixun Lan <yixun.lan@amlogic.com> writes:

> This is a rework for the patch [v4 4/4] of previous series,
> which mean this will make the patch [1] obsolete.
>
> Changes since v4:
>  * separate DTS for ARM(32bit) vs ARM64
>  * add ACK from Martin

Thanks for splitting it up.

> [1] [PATCH v4 4/4] ARM64: dts: meson: drop "sana" clock from SAR ADC
> http://lists.infradead.org/pipermail/linux-amlogic/2017-November/005266.html
>
> Xingyu Chen (2):
>   ARM64: dts: meson: drop "sana" clock from SAR ADC

Applied to v4.16/dt64

>   ARM: dts: meson: drop "sana" clock from SAR ADC

Applied to v4.16/dt

Thanks,

Kevin
