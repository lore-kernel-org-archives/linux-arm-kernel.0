From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 9 May 2012 13:01:57 +0100
Subject: [PATCH V2 06/11] ASoC: fsl_ssi: convert to use devm_clk_get
In-Reply-To: <CAAQ0ZWSiRysfkUnu2ZoDXFtiJz-nfrQ-DTKOgCpKpCe5LpQj3Q@mail.gmail.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-7-git-send-email-richard.zhao@freescale.com>
 <20120509115041.GM3955@opensource.wolfsonmicro.com>
 <CAAQ0ZWSiRysfkUnu2ZoDXFtiJz-nfrQ-DTKOgCpKpCe5LpQj3Q@mail.gmail.com>
Message-ID: <20120509120156.GP3955@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 07:59:20PM +0800, Shawn Guo wrote:
> On 9 May 2012 19:50, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > I'll apply this when devm_clk_get() makes it into mainline (hopefully in
> > the merge window); please remind me if I forget.

> We will have rmk's clkdev branch appear on arm-soc as dependency
> anyway.  Can we have this series go over arm-soc tree, since we will
> have all the dependencies on clk and pinctrl meet and conflicts solved
> there?

This change is totally unrelated to the rest of the series, it's just a
random cleanup to the driver - it really shouldn't have been part of the
series at all.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120509/e57d1db2/attachment-0001.sig>
