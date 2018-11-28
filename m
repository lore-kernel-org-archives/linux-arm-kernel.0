From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 11:05:04 +0800
Subject: [PATCH 06/77] ARM: dts: sun5i: Remove skeleton to avoid warnings
In-Reply-To: <856695e90059a2e85dd3b0aacc9e6881967b0ccf.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <856695e90059a2e85dd3b0aacc9e6881967b0ccf.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v66c-f8o=Yai_Yr02cuk976TTbpR+0oxwPnP_WUB0WPjQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Using skeleton.dtsi will create a memory node that will generate a warning
> in DTC. However, that node will be created by the bootloader, so we can
> just remove it entirely in order to remove that warning.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
