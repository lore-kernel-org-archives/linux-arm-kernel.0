From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 29 Jul 2013 19:04:02 -0300
Subject: [BUILD BREAKAGE] today's next build broken for pcm037
In-Reply-To: <Pine.LNX.4.64.1307291458560.14405@axis700.grange>
References: <Pine.LNX.4.64.1307291458560.14405@axis700.grange>
Message-ID: <CAOMZO5CO54+HgMHh+p_h386P72odZinF9a0T198K6sMLCrYZzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

On Mon, Jul 29, 2013 at 10:03 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Hi Sascha,
>
> Attached .config fails to build for me with today's next as follows:
>
> ERROR: "imx_pcm_dma_init" [sound/soc/fsl/snd-soc-fsl-ssi.ko] undefined!
> ERROR: "imx_pcm_dma_exit" [sound/soc/fsl/snd-soc-fsl-ssi.ko] undefined!

Just sent a patch for this:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-July/064715.html

Regards,

Fabio Estevam
