From: matt@genesi-usa.com (Matt Sealey)
Date: Fri, 18 Jan 2013 13:13:14 -0600
Subject: [PATCH v3] sdma-imx: Add SDMA firmware for Freescale i.MX SOCs
In-Reply-To: <1358437708-18717-1-git-send-email-fabio.estevam@freescale.com>
References: <1358437708-18717-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <CAKGA1b=4o58nMP5ez6V1d20vFXbYx3Lqq2YDcXGgnOGBy4OTzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 17, 2013 at 9:48 AM, Fabio Estevam
<fabio.estevam@freescale.com> wrote:
> Add SDMA firmware for Freescale i.MX SOCs.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v2:
> - Drop unrecognized chars by replacing double spaces with tabs, which caused
> issues on some mail clients
> Changes since v1:
> - Drop 'to' information from the file name.
>
>  LICENCE.fsl_firmware        |  140 +++++++++++++++++++++++++++++++++++++++++++
>  WHENCE                      |   13 ++++
>  imx/sdma/sdma-imx25.bin |  Bin 0 -> 694 bytes
>  imx/sdma/sdma-imx31.bin |  Bin 0 -> 3762 bytes
>  imx/sdma/sdma-imx35.bin |  Bin 0 -> 1746 bytes
>  imx/sdma/sdma-imx51.bin     |  Bin 0 -> 1894 bytes
>  imx/sdma/sdma-imx53.bin     |  Bin 0 -> 1406 bytes
>  imx/sdma/sdma-imx6q.bin |  Bin 0 -> 1838 bytes

Hi Fabio,

You are an absolute star; but I would suggest only that sdma-imx6q.bin
is misnamed here, since this firmware works on *all* i.MX6 models
(Quad, Dual, DualLite, Solo, SoloLite) and not just q for Quad.. is
there any reason why it would have to have this very
SoC-variant-specific naming convention if we also dropped support for
naming tapeouts for each chip?

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
