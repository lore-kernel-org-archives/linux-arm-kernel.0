From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 18 Oct 2016 15:39:03 +0800
Subject: [PATCH v2 8/9] ARM: sunxi: Remove useless allwinner, pull property
In-Reply-To: <b643d1e525835365a6ae63bcd065cb3650a839d6.1476200742.git-series.maxime.ripard@free-electrons.com>
References: <cover.7edc6c25be8a5e2efdda6a82e102dbf7ece6aa64.1476200742.git-series.maxime.ripard@free-electrons.com>
 <b643d1e525835365a6ae63bcd065cb3650a839d6.1476200742.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64E64vXEmfFymVONXbecMWzLD2VTSfDa-AOh5i1uPOLOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2016 at 11:46 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The allwinner,pull property set to NO_PULL was really considered our
> default (and wasn't even changing the default value in the code).
>
> Remove these properties to make it obvious that we do not set anything in
> such a case.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
