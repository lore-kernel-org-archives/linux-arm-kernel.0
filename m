From: joonas.kylmala@iki.fi (=?UTF-8?Q?Joonas_Kylm=c3=a4l=c3=a4?=)
Date: Wed, 18 Oct 2017 15:00:00 +0000
Subject: [linux-sunxi] [PATCH v2 6/8] ARM: dts: sun8i: a83t: Move mmc1
 pinctrl setting to dtsi file
In-Reply-To: <20171018083138.14517-7-wens@csie.org>
References: <20171018083138.14517-1-wens@csie.org>
 <20171018083138.14517-7-wens@csie.org>
Message-ID: <f85a30e2-5a9d-a7ba-0010-6602cabaf83e@riseup.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Chen-Yu Tsai:
> mmc1 only has 1 possible pinmux setting.

What if someone is using the MMC with bus width 1 and then using the
remaining 3 pins for something else?

Joonas
