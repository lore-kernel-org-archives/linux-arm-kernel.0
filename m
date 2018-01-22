From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 22 Jan 2018 21:28:52 +0800
Subject: [PATCH v4 08/13] drm/sun4i: Add a driver for the display frontend
In-Reply-To: <029cdc3478bf89d422f5e8d9e600baf5e48ce4db.1516613040.git-series.maxime.ripard@free-electrons.com>
References: <cover.671c2fcad4ca649d65bd2b9982a8361befa8bfd1.1516613040.git-series.maxime.ripard@free-electrons.com>
 <029cdc3478bf89d422f5e8d9e600baf5e48ce4db.1516613040.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64jwNkF1LmEF3Am0Kf7pFevDB1FOka574-F8zh=Phr-RQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 22, 2018 at 5:25 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The display frontend is an hardware block that can be used to implement
> some more advanced features like hardware scaling or colorspace
> conversions. It can also be used to implement the output format of the VPU.
>
> Let's create a minimal driver for it that will only enable the hardware
> scaling features.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
