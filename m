From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 22 Aug 2012 16:38:26 -0300
Subject: [PATCH v2 1/2] ARM: clk-imx35: Fix SSI clock registration
In-Reply-To: <20120822192723.GS7995@opensource.wolfsonmicro.com>
References: <1345466362-2576-1-git-send-email-fabio.estevam@freescale.com>
 <20120822192723.GS7995@opensource.wolfsonmicro.com>
Message-ID: <CAOMZO5B2feJzbqEQgJm_gKDcZPSKuckXWj=s+b+5R39Tnv7-kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 22, 2012 at 4:27 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:

> Tested-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> in that it stops boot hanging on the board, though it still doesn't make
> AC'97 come out of reset happily.  That's probably some separate issue
> (pinmux perhaps?) though.

Yes, looks like a separate issue.

Did imx_ssi_probe go successfully? What is the error log you are getting?

Regards,

Fabio Estevam
