From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 11 Nov 2013 17:26:53 +0100
Subject: [RFC] ASoC: fsl-ssi: Missing DMA-Request workaround
In-Reply-To: <528100AE.60901@freescale.com>
References: <1384185816-7730-1-git-send-email-mpa@pengutronix.de>
 <528100AE.60901@freescale.com>
Message-ID: <20131111162653.GC30263@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Mon, Nov 11, 2013 at 02:07:10PM -0200, Fabio Estevam wrote:
> Hi Markus,
> 
> 
> On 11/11/2013 02:03 PM, Markus Pargmann wrote:
> >There is a hardware issue when using capture and playback at the same
> >time. In the tested scenario, the capture stream was started slightly
> 
> Just to confirm: do you have this patch applied?
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/sound/soc/fsl/fsl_ssi.c?id=64d2307c3b7daa03dbc0c3a6b514709dd7b6eaee

I just applied this patch and tested, but the issue is still there
(DMA-Request missing).

Regards,

Markus Pargmann

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
