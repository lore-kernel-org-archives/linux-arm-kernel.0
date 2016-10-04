From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 4 Oct 2016 10:29:46 +0800
Subject: [PATCH 5/9] pinctrl: sunxi: Support generic binding
In-Reply-To: <1b45160fb37e2dcabd855d2192fc403a1c4db324.1475489558.git-series.maxime.ripard@free-electrons.com>
References: <cover.26c6f76b361d146fb079d744251f020ef6d2db7d.1475489558.git-series.maxime.ripard@free-electrons.com>
 <1b45160fb37e2dcabd855d2192fc403a1c4db324.1475489558.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66jSJx1X0vvXyCF9TKyKO4MWmNMO1jK=x9W9Bzs=C0vog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 3, 2016 at 6:21 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Our bindings are mostly irrelevant now that we have generic pinctrl
> bindings that cover exactly the same uses cases.
>
> Add support for the new ones, and obviously keep our old binding support in
> order to keep the ABI stable.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
