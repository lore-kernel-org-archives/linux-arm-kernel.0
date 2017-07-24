From: robh@kernel.org (Rob Herring)
Date: Mon, 24 Jul 2017 14:59:05 -0500
Subject: [PATCH 3/4] soc: renesas: rcar-sysc: Add support for R-Car D3
 power areas
In-Reply-To: <1500554094-22198-4-git-send-email-geert+renesas@glider.be>
References: <1500554094-22198-1-git-send-email-geert+renesas@glider.be>
 <1500554094-22198-4-git-send-email-geert+renesas@glider.be>
Message-ID: <20170724195905.3wsf6kuxfgygbsuw@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 02:34:53PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: devicetree at vger.kernel.org
> ---
>  .../bindings/power/renesas,rcar-sysc.txt           |  1 +
>  drivers/soc/renesas/Kconfig                        |  5 ++++
>  drivers/soc/renesas/Makefile                       |  1 +
>  drivers/soc/renesas/r8a77995-sysc.c                | 31 ++++++++++++++++++++++
>  drivers/soc/renesas/rcar-sysc.c                    |  3 +++
>  drivers/soc/renesas/rcar-sysc.h                    |  1 +
>  6 files changed, 42 insertions(+)
>  create mode 100644 drivers/soc/renesas/r8a77995-sysc.c

Acked-by: Rob Herring <robh@kernel.org>
