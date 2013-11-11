From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 11 Nov 2013 14:07:10 -0200
Subject: [RFC] ASoC: fsl-ssi: Missing DMA-Request workaround
In-Reply-To: <1384185816-7730-1-git-send-email-mpa@pengutronix.de>
References: <1384185816-7730-1-git-send-email-mpa@pengutronix.de>
Message-ID: <528100AE.60901@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,


On 11/11/2013 02:03 PM, Markus Pargmann wrote:
> There is a hardware issue when using capture and playback at the same
> time. In the tested scenario, the capture stream was started slightly

Just to confirm: do you have this patch applied?
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/sound/soc/fsl/fsl_ssi.c?id=64d2307c3b7daa03dbc0c3a6b514709dd7b6eaee

Regards,

Fabio Estevam
