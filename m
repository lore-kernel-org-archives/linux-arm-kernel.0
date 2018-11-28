From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 28 Nov 2018 09:33:35 +0000
Subject: [PATCH 12/14] mfd: axp20x: use explicit bit defines
In-Reply-To: <a0f3f8a763d948159de122b8071b5de4bfc785c0.1543245984.git-series.plaes@plaes.org>
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <a0f3f8a763d948159de122b8071b5de4bfc785c0.1543245984.git-series.plaes@plaes.org>
Message-ID: <20181128093335.GB4272@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 26 Nov 2018, Priit Laes wrote:

> From: Olliver Schinagl <oliver@schinagl.nl>
> 
> The AXP20X_OFF define is an actual specific bit, define it as such.
> 
> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  drivers/mfd/axp20x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
