From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 21 Jan 2017 09:28:44 +0800
Subject: [PATCH v3 4/7] clk: sunxi-ng: Implement global pre-divider
In-Reply-To: <1e37c723845efe18540268a168baeb81a86e8179.1484897383.git-series.maxime.ripard@free-electrons.com>
References: <cover.5df5469d9c7a6233e225a875dca513a03b05e871.1484897383.git-series.maxime.ripard@free-electrons.com>
 <1e37c723845efe18540268a168baeb81a86e8179.1484897383.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65TW=WdcMufHsdKn2n4WsKwedE+M45qYQbmxLfrhYjf9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2017 at 3:29 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Some clocks have a global pre-divider that applies to all their parents.
>
> Since it might also apply to clocks that have a single parent, this is
> merged in the ccu_common structure, unlike the other pre-divider settings
> that are tied to a specific index, and thus a specific parent.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
