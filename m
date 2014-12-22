From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 22 Dec 2014 15:41:04 -0200
Subject: [PATCH] ARM: dts: imx6dl-udoo: Add board support based off
 imx6q-udoo
In-Reply-To: <1419269361-6095-1-git-send-email-robertcnelson@gmail.com>
References: <1419269361-6095-1-git-send-email-robertcnelson@gmail.com>
Message-ID: <CAOMZO5ByFrTFoPUeRPBYxjB74Xn1BPQXzDxSaa+SiW_Ks5JZOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 22, 2014 at 3:29 PM, Robert Nelson <robertcnelson@gmail.com> wrote:

> +/dts-v1/;
> +#include "imx6dl.dtsi"
> +#include "imx6qdl-udoo.dtsi"
> +
> +/ {
> +       model = "Udoo i.MX6 Dual Board";

It would be better to use "Udoo i.MX6 Dual-lite Board" in order to
avoid confusion with the i.MX6 Dual variant.

Other than that:

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
