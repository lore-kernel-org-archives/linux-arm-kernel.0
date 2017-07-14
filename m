From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 14 Jul 2017 11:09:07 +0800
Subject: [PATCH 02/18] drm/sun4i: Add if statement instead of depends on
In-Reply-To: <d51d45d57d2bacaa5bafcd861aa0142fcaf0ad77.1499955058.git-series.maxime.ripard@free-electrons.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
 <d51d45d57d2bacaa5bafcd861aa0142fcaf0ad77.1499955058.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64KXCm1SzCz1hSkk1WOA03rju5_v_Q9XdF=cSs26Wz+Tw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 10:12 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The depends on relationship is obvious, and using an if statement will
> propagate it to every option without the need for each and every one of
> them to define it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
