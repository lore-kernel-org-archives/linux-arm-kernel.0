From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 8 Oct 2012 20:47:22 -0300
Subject: [alsa-devel] [PATCH v2 1/2] ARM: imx: clk: Split SSI clock into
 'ipg' and 'per'
In-Reply-To: <20121008214452.GA27665@pengutronix.de>
References: <1349725213-11354-1-git-send-email-fabio.estevam@freescale.com>
 <20121008214452.GA27665@pengutronix.de>
Message-ID: <CAOMZO5ACVeMwGcjSXcEqyHMc9G3KgyrL-uC=wvjmf1AQOAhgWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Oct 8, 2012 at 6:44 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

> I am not sure it's good to work around that issue in the ssi driver. We
> could also just enable the clock in the clk driver as it seems to be a
> ccm related issue.

Yes, it would be better if we could fix this in clk-imx27 instead, but
I was not able to provide such fix yet.

Regards,

Fabio Estevam
