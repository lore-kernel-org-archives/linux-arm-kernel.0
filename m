From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 8 Sep 2011 23:42:10 +0200
Subject: [PATCH v3 1/1] ASoC: mxs-saif: add record function
In-Reply-To: <CABS+qY12ChK=aA-eOERH5ATWKcQdp3wE48SsBNcpe0nDzXWOMw@mail.gmail.com>
References: <1315399910-6525-1-git-send-email-b29396@freescale.com>
	<CABS+qY12ChK=aA-eOERH5ATWKcQdp3wE48SsBNcpe0nDzXWOMw@mail.gmail.com>
Message-ID: <20110908214210.GB4423@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2011 at 10:29:12PM +0100, Girdwood, Liam wrote:
>    On 7 September 2011 13:51, Dong Aisheng <b29396@freescale.com> wrote:
> 
>      1. add different clkmux mode handling
>      SAIF can use two instances to implement full duplex (playback &
>      recording) and record saif may work on EXTMASTER mode which is
>      using other saif's BITCLK&LRCLK.
> 
>      The clkmux mode could be set in pdata->init() in mach-specific code.
>      For generic saif driver, it only needs to know who is his master
>      and the master id is also provided in mach-specific code.
> 
>      2. support playback and capture simutaneously however the sample
>      rates can not be different due to hw limitation.
> 
>      Signed-off-by: Dong Aisheng <b29396@freescale.com>
>      Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>      Cc: Liam Girdwood <lrg@ti.com>
>      Cc: Sascha Hauer <s.hauer@pengutronix.de>
>      Cc: Wolfram Sang <w.sang@pengutronix.de>
>    Acked-by Liam Girdwood <lrg@ti.com>

Mark, please wait for my tag. This patch is related to the mach-specific parts
and both parts should be proper. Shouldn't take me longer than the end of this
week.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110908/a314c848/attachment.sig>
