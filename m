From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 4 May 2017 11:25:34 +0800
Subject: [PATCH v2 5/20] clk: sunxi-ng: mux: split out the pre-divider
 computation code
In-Reply-To: <fcda95612e72a1a5bb6010993181e638a41511e9.1493812478.git-series.maxime.ripard@free-electrons.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
 <fcda95612e72a1a5bb6010993181e638a41511e9.1493812478.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65TyYoV97LmoEPseO5oxcNNyPiLncwxC9y_Hzi0XhyzMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 3, 2017 at 7:59 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The pre-divider retrieval code was merged into the function to apply the
> current pre-divider onto the parent clock rate so that we can use that
> adjusted value to do our factors computation.
>
> However, since we'll need to do the reverse operation, we need to split out
> that code into a function that will be shared.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

Seems this would conflict with my "clk: sunxi-ng: Support multiple variable
pre-dividers" patch though. We'll see how this works out.
