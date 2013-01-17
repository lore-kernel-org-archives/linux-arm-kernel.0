From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Jan 2013 21:50:31 +0800
Subject: [PATCH] sdma-imx: Add SDMA firmware for Freescale i.MX SOCs
In-Reply-To: <1358424987-22312-1-git-send-email-fabio.estevam@freescale.com>
References: <1358424987-22312-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130117135028.GA29285@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Thu, Jan 17, 2013 at 10:16:27AM -0200, Fabio Estevam wrote:
> Add SDMA firmware for Freescale i.MX SOCs.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  LICENCE.fsl_firmware        |  140 +++++++++++++++++++++++++++++++++++++++++++
>  WHENCE                      |   13 ++++
>  imx/sdma/sdma-imx25-to1.bin |  Bin 0 -> 694 bytes
>  imx/sdma/sdma-imx31-to2.bin |  Bin 0 -> 3762 bytes
>  imx/sdma/sdma-imx35-to2.bin |  Bin 0 -> 1746 bytes
>  imx/sdma/sdma-imx51.bin     |  Bin 0 -> 1894 bytes
>  imx/sdma/sdma-imx53.bin     |  Bin 0 -> 1406 bytes
>  imx/sdma/sdma-imx6q-to1.bin |  Bin 0 -> 1838 bytes

Can we have a consistent name schema?  If we want to have a "tox"
suffix, we should give one for imx51 and imx53 too.  Or we remove
the suffix for everyone else based on the fact that we will only
upload the firmware for production revision.

I'm fine with either way.  Just want to see them be named consistently.

Shawn
