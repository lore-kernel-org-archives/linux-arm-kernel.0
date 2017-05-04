From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 4 May 2017 11:20:27 +0800
Subject: [PATCH v2 3/20] clk: sunxi-ng: div: Switch to divider_round_rate
In-Reply-To: <8ea7c8c0ac01fe06f7ded94e03532a1838f2bf8f.1493812478.git-series.maxime.ripard@free-electrons.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
 <8ea7c8c0ac01fe06f7ded94e03532a1838f2bf8f.1493812478.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64d2VXTuqHLv6o8M35+RNa8R8BH+9m8N+ATe81gtu4ZJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 3, 2017 at 7:59 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> divider_round_rate already evaluates changing the parent rate if

  ^^^ Might want to update this, as you are now using the new function
      you added in patch 1.

> CLK_SET_RATE_PARENT is set. Now that we can do that on muxes too, let's
> just use it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>
