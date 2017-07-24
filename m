From: robh@kernel.org (Rob Herring)
Date: Mon, 24 Jul 2017 15:06:13 -0500
Subject: [PATCH 4/4] soc: renesas: rcar-rst: Add support for R-Car D3
In-Reply-To: <1500554094-22198-5-git-send-email-geert+renesas@glider.be>
References: <1500554094-22198-1-git-send-email-geert+renesas@glider.be>
 <1500554094-22198-5-git-send-email-geert+renesas@glider.be>
Message-ID: <20170724200613.wpwsn4m4r2rhwwik@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 02:34:54PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: devicetree at vger.kernel.org
> ---
>  Documentation/devicetree/bindings/reset/renesas,rst.txt | 1 +
>  drivers/soc/renesas/Kconfig                             | 2 +-
>  drivers/soc/renesas/rcar-rst.c                          | 1 +
>  3 files changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
