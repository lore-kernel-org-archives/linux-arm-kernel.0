From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 23 Jan 2017 12:27:54 +0800
Subject: [PATCH v4 3/8] clk: sunxi-ng: mult: Fix minimum in round rate
In-Reply-To: <cad6b82633303e0fe3b231dce364629bc723a808.1485039043.git-series.maxime.ripard@free-electrons.com>
References: <cover.04f797fe015b05f19b1d69d0650680baffb27055.1485039043.git-series.maxime.ripard@free-electrons.com>
 <cad6b82633303e0fe3b231dce364629bc723a808.1485039043.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64W+mo3ByDmD7i_tuXVr+mXd0zqY1gvkPT-hrZsV-BqxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2017 at 6:50 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The previous code was always taking 1 as the minimum in it's round_rate
> function, ignoring entirely what was set as minimum in the clock
> definition.
>
> Make sure that's not the case anymore.
>
> Fixes: 2beaa601c849 ("clk: sunxi-ng: Implement minimum for multipliers")
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
