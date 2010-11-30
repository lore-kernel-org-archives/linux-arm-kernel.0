From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 29 Nov 2010 22:10:49 -0200
Subject: [PATCH] ARM: imx: Add mx53 changes to crm_regs
In-Reply-To: <1291071265-4238-1-git-send-email-Dinh.Nguyen@freescale.com>
References: <1291071265-4238-1-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <AANLkTikbroTO6A=1_nBrO=y-O-MiGgtZAN5tg32+4-c=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

On Mon, Nov 29, 2010 at 8:54 PM,  <Dinh.Nguyen@freescale.com> wrote:
...
>
> ?/* eSDHC */
> -CLK_GET_RATE(esdhc1, 1, ESDHC1_MSHC1)
> -CLK_SET_PARENT(esdhc1, 1, ESDHC1_MSHC1)
> -CLK_SET_RATE(esdhc1, 1, ESDHC1_MSHC1)
> +CLK_GET_RATE(esdhc1, 1, ESDHC1_MSHC2)
> +CLK_SET_PARENT(esdhc1, 1, ESDHC1_MSHC2)
> +CLK_SET_RATE(esdhc1, 1, ESDHC1_MSHC2)
>
> -CLK_GET_RATE(esdhc2, 1, ESDHC2_MSHC2)
> -CLK_SET_PARENT(esdhc2, 1, ESDHC2_MSHC2)
> -CLK_SET_RATE(esdhc2, 1, ESDHC2_MSHC2)
> +CLK_GET_RATE(esdhc2, 1, ESDHC2_3_MSHC2)
> +CLK_SET_PARENT(esdhc2, 1, ESDHC2_3_MSHC2)
> +CLK_SET_RATE(esdhc2, 1, ESDHC2_3_MSHC2)

Shouldn?t this be part of another patch?

Regards,

Fabio Estevam
