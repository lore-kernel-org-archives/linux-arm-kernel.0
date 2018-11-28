From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 19:54:26 +0800
Subject: [PATCH 37/77] ARM: dts: sun7i: Change clock node names to avoid
 warnings
In-Reply-To: <2e9319196fa1e19c66db990e1bf71cc5b45cdcfc.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
 <2e9319196fa1e19c66db990e1bf71cc5b45cdcfc.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <CAGb2v64WmPqJcv3pLjXKE7VJAST3iSRfsExWUodoR39YmnM5xA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 27, 2018 at 8:46 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Our oscillators clock names have a unit address, but no reg property, which
> generates a warning in DTC. Change these names to remove those unit
> addresses.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
