From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 21 Jan 2013 15:34:01 +0800
Subject: [PATCH v3] sdma-imx: Add SDMA firmware for Freescale i.MX SOCs
In-Reply-To: <CAKGA1b=4o58nMP5ez6V1d20vFXbYx3Lqq2YDcXGgnOGBy4OTzw@mail.gmail.com>
References: <1358437708-18717-1-git-send-email-fabio.estevam@freescale.com>
 <CAKGA1b=4o58nMP5ez6V1d20vFXbYx3Lqq2YDcXGgnOGBy4OTzw@mail.gmail.com>
Message-ID: <20130121073358.GD2272@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 18, 2013 at 01:13:14PM -0600, Matt Sealey wrote:
> >  imx/sdma/sdma-imx25.bin |  Bin 0 -> 694 bytes
> >  imx/sdma/sdma-imx31.bin |  Bin 0 -> 3762 bytes
> >  imx/sdma/sdma-imx35.bin |  Bin 0 -> 1746 bytes
> >  imx/sdma/sdma-imx51.bin     |  Bin 0 -> 1894 bytes
> >  imx/sdma/sdma-imx53.bin     |  Bin 0 -> 1406 bytes
> >  imx/sdma/sdma-imx6q.bin |  Bin 0 -> 1838 bytes
> 
> Hi Fabio,
> 
> You are an absolute star; but I would suggest only that sdma-imx6q.bin
> is misnamed here, since this firmware works on *all* i.MX6 models
> (Quad, Dual, DualLite, Solo, SoloLite) and not just q for Quad.. is
> there any reason why it would have to have this very
> SoC-variant-specific naming convention if we also dropped support for
> naming tapeouts for each chip?
> 
SoC-variant-specific naming convention is widely used in device tree
binding for versioning.  I would say in this case that all other i.MX6
models' SDMA firmware is completely compatible with imx6q's.

Shawn
