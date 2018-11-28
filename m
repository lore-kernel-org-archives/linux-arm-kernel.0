From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 28 Nov 2018 09:33:07 +0000
Subject: [PATCH 11/14] mfd: axp20x: Clean up included headers
In-Reply-To: <1567a4f47e802c592a3f109c7b5e0656528e2a5c.1543245984.git-series.plaes@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <1567a4f47e802c592a3f109c7b5e0656528e2a5c.1543245984.git-series.plaes@plaes.org>
Message-ID: <20181128093306.GA4272@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 26 Nov 2018, Priit Laes wrote:

> From: Olliver Schinagl <oliver@schinagl.nl>
> 
> Add the bitops.h header as we need it, alphabetize header order.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  drivers/mfd/axp20x.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Nit: You are making 2 separate functional changes here.  In future
please submit functional changes in separate patches.

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
