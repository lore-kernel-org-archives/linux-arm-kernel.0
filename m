From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 14 Jul 2017 11:57:54 +0800
Subject: [PATCH 08/18] drm/sun4i: tcon: Add TRI finish interrupt for vblank
In-Reply-To: <8114707d8063d0c9e67694528925baf4f4ee2f7c.1499955058.git-series.maxime.ripard@free-electrons.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
 <8114707d8063d0c9e67694528925baf4f4ee2f7c.1499955058.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67yHqy1cGd6Op0KT7N+4Ew6j-jA+STYc5ZSm+8Z3ZDGhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 10:13 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The "CPU" (or Intel 8080) interface uses a different interrupt called
> TRI_FINISH (most likely TRI being for trigger) to notify the end of frames,
> and hence the VBLANK period.
>
> And that interrupt to the possible VBLANK interrupts source.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
