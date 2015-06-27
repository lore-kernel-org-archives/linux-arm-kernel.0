From: tremyfr@gmail.com (Philippe Reynes)
Date: Sat, 27 Jun 2015 23:30:58 +0200
Subject: [PATCH] ARM: dts: imx27: Adjust the GPT compatible string
In-Reply-To: <1435438273-19741-1-git-send-email-festevam@gmail.com>
References: <1435438273-19741-1-git-send-email-festevam@gmail.com>
Message-ID: <558F1612.4050701@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/06/15 22:51, Fabio Estevam wrote:
> From: Fabio Estevam<fabio.estevam@freescale.com>
>
> include/soc/imx/timer.h describes well the different versions of
> the GPT block among the imx family:
>
> enum imx_gpt_type {
> 	GPT_TYPE_IMX1,		/* i.MX1 */
> 	GPT_TYPE_IMX21,		/* i.MX21/27 */
> 	GPT_TYPE_IMX31,		/* i.MX31/35/25/37/51/6Q */
> 	GPT_TYPE_IMX6DL,	/* i.MX6DL/SX/SL */
> };
>
> So the proper compatible string for the MX27 case should be
> "fsl,imx21-gpt".
>
> Signed-off-by: Fabio Estevam<fabio.estevam@freescale.com>


Reviewed-by: Philippe Reynes <tremyfr@gmail.com>
