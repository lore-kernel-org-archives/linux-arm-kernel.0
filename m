From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 24 Apr 2015 08:33:51 -0300
Subject: [PATCH resend] ARM: dts: imx25: Add #pwm-cells to pwm4
In-Reply-To: <1429860453-25356-1-git-send-email-mpa@pengutronix.de>
References: <1429860453-25356-1-git-send-email-mpa@pengutronix.de>
Message-ID: <CAOMZO5A8d8ODP=GAN04cQ8O09N-1qZu8wS+J7hruc+P2+5cpBQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 24, 2015 at 4:27 AM, Markus Pargmann <mpa@pengutronix.de> wrote:
> The property '#pwm-cells' is currently missing. It is not possible to
> use pwm4 without this property.
>
> Cc: <stable@vger.kernel.org>
> Cc: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks
