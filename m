From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 28 Aug 2018 19:25:48 -0300
Subject: [PATCH 1/2][RESEND] ARM: dts: Add big-endian in nor node for
 ls1021a
In-Reply-To: <20180828065936.8040-2-prabhakar.kushwaha@nxp.com>
References: <20180828065936.8040-1-prabhakar.kushwaha@nxp.com>
 <20180828065936.8040-2-prabhakar.kushwaha@nxp.com>
Message-ID: <CAOMZO5BVrK98ksQ2KBiXTy6O-nXjOG8_fFueRRXHZOwCMJ1UGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 3:59 AM, Prabhakar Kushwaha
<prabhakar.kushwaha@nxp.com> wrote:

> diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
> index 499f41a2c6f0..923a25760516 100644
> --- a/arch/arm/boot/dts/ls1021a-qds.dts
> +++ b/arch/arm/boot/dts/ls1021a-qds.dts
> @@ -1,5 +1,6 @@
>  /*
>   * Copyright 2013-2014 Freescale Semiconductor, Inc.
> + * Copyright 2018 NXP

This line is unrelated to the big-endian change.
