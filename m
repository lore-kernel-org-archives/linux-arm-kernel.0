From: oskar@scara.com (Oskar Schirmer)
Date: 1 Nov 2013 10:17:50 +0000
Subject: [PATCHv2 6/8] ASoC: fsl: add SGTL5000 based audio machine driver.
In-Reply-To: <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-7-git-send-email-Li.Xiubo@freescale.com>
Message-ID: <20131101101750.GB16492@curry>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not that it would improve functionality, but:

On Fri, Nov 01, 2013 at 15:04:53 +0800, Xiubo Li wrote:
[...]
> diff --git a/sound/soc/fsl/fsl-sgtl5000-vf610.c b/sound/soc/fsl/fsl-sgtl5000-vf610.c
> new file mode 100644
> index 0000000..f535b42
> --- /dev/null
> +++ b/sound/soc/fsl/fsl-sgtl5000-vf610.c
> @@ -0,0 +1,208 @@
> +/*
> + * Freeacale ALSA SoC Audio using SGT1500 as codec.
          ^                             ^   ^
     "Freescale"                    "SGTL5000"

regards,
  Oskar
