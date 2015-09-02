From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 2 Sep 2015 12:57:00 -0300
Subject: [PATCH] ARM: dts: imx6sl: Complete the dcp node
In-Reply-To: <1441207532.3137.22.camel@pengutronix.de>
References: <1441206417-27805-1-git-send-email-festevam@gmail.com>
 <1441207532.3137.22.camel@pengutronix.de>
Message-ID: <CAOMZO5CbO+mX8=Qv=5OWdA3hLaVLSo6NQ87rf+zmJQ+r9eX1Xg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 2, 2015 at 12:25 PM, Lucas Stach <l.stach@pengutronix.de> wrote:

> Can we please start to make it good habit to always introduce a new
> compatible to the DTs, even if the blocks are the same in theory?
>
> We already had situations where the SoC IP integration exposed bugs,
> which need driver workarounds and the only way to detect such situations
> is to check the machine compatible in the driver, which is really ugly.
>
> So can we please make this:
>         compatible = "fsl,imx6sl-dcp", "fsl,imx28-dcp";

Thanks for the suggestion. Did this in v2.

Regards,

Fabio Estevam
