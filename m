From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 20:34:03 +0800
Subject: [PATCH 51/77] ARM: dts: sun8i: a23/a33: Remove skeleton and
 memory to avoid warnings
In-Reply-To: <44c1d032168b5accb2a4bbc6d5df7884ce688277.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <44c1d032168b5accb2a4bbc6d5df7884ce688277.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v64dV3diaF+5uKMa3HrfwKdDSPMmxZojZdfFsiYMjuT8QQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:47 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Using skeleton.dtsi will create a memory node that will generate a warning
> in DTC. However, that node will be created by the bootloader, so we can
> just remove it entirely in order to remove that warning.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
