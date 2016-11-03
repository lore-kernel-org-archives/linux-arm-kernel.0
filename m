From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 3 Nov 2016 09:52:26 +0800
Subject: [PATCH v6 1/4] clk: sunxi-ng: Add A64 clocks
In-Reply-To: <fb266cd536fce7fc7800189f3aa0f8cd73d75ec3.1478123413.git-series.maxime.ripard@free-electrons.com>
References: <cover.6088b64645bde9b847d2fede5ecb15a0e204a9dd.1478123413.git-series.maxime.ripard@free-electrons.com>
 <fb266cd536fce7fc7800189f3aa0f8cd73d75ec3.1478123413.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v676Ddz1wmRwDGwTd8gGH5AJJBkyAe-WyvZ=D+2OKoRb4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 3, 2016 at 5:50 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Add the A64 CCU clocks set.
>
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

I thought I acked this one...

Skimming through it again, I think you would want to add CLK_SET_PARENT_RATE
to the hdmi and mipi dsi module clocks.

Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>
