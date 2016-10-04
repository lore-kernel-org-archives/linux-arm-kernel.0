From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 4 Oct 2016 10:35:17 +0800
Subject: [PATCH 8/9] ARM: sunxi: Remove useless allwinner,pull property
In-Reply-To: <7b4c2580fc98e0877c14736b7edf3738128591ae.1475489558.git-series.maxime.ripard@free-electrons.com>
References: <cover.26c6f76b361d146fb079d744251f020ef6d2db7d.1475489558.git-series.maxime.ripard@free-electrons.com>
 <7b4c2580fc98e0877c14736b7edf3738128591ae.1475489558.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64yYTukkWj78yfSULAB459=kyxdTNwioncWB8N8xXBYHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 3, 2016 at 6:21 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The allwinner,pull property set to NO_PULL was really considered our
> default (and wasn't even changing the default value in the code).
>
> Remove these properties to make it obvious that we do not set anything in
> such a case.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Same comment as the last patch.

ChenYu
