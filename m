From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 4 May 2017 11:19:22 +0800
Subject: [PATCH v2 2/20] clk: sunxi-ng: Pass the parent and a pointer to
 the clocks round rate
In-Reply-To: <83d508e254c6656aee02bbe5c410922ea66cf3d7.1493812478.git-series.maxime.ripard@free-electrons.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
 <83d508e254c6656aee02bbe5c410922ea66cf3d7.1493812478.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67zHc7DPGGLrRnVC_G9bE8jx3DephcveaZFGbassBbYjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 3, 2017 at 7:59 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The clocks might need to modify their parent clocks. In order to make that
> possible, give them access to the parent clock being evaluated, and to a
> pointer to the parent rate so that they can modify it if needed.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
