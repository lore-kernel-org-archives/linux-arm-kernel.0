From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 14 Jul 2017 11:15:18 +0800
Subject: [PATCH 04/18] drm/sun4i: Remove useless atomic_check
In-Reply-To: <effdc5f1e0fe485b141c057bb66f9dadf7433a88.1499955058.git-series.maxime.ripard@free-electrons.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
 <effdc5f1e0fe485b141c057bb66f9dadf7433a88.1499955058.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67=x+6tdKsKEkY2VS75H561zUfh55h2sNUcrCERr+z72A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 10:12 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The atomic_check callback is optional, and we don't implement anything in
> some parts of our drivers. Let's remove it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
