From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 16 Dec 2009 08:34:06 +0200
Subject: [PATCH 3/4] fec: add support for Freescale i.MX25 PDK (3DS)
In-Reply-To: <4B282644.8030104@snapgear.com>
References: <cover.1260785451.git.baruch@tkos.co.il>
	<fb518184b206ec2727deda111cc5364134ace69a.1260785451.git.baruch@tkos.co.il>
	<20091214103348.GV15126@pengutronix.de>
	<20091215083142.GB18290@jasper.tkos.co.il>
	<4B277878.1050804@snapgear.com> <20091215201109.GA2621@tarshish>
	<4B282644.8030104@snapgear.com>
Message-ID: <20091216063402.GA13160@jasper.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Wed, Dec 16, 2009 at 10:13:56AM +1000, Greg Ungerer wrote:
> Baruch Siach wrote:
> >On Tue, Dec 15, 2009 at 09:52:24PM +1000, Greg Ungerer wrote:
> >>On 12/15/2009 06:31 PM, Baruch Siach wrote:
> >>>+#ifndef CONFIG_M5272
> >>I would suggest making this conditional on FEC_MIIGSK_ENR.
> >>Although the CONFIG_M5272 is the only case here currently,
> >>that may change over the years. And using this here may not
> >>be obvious to the causual code reader, since the register
> >>offset definitions don't explicitly key on CONFIG_M5272.
> >
> >OK, I'll change this conditional.
> >
> >Can I take this as an Ack from you?
> 
> With that conditional check changed, sure:
> 
> Acked-by:  Greg Ungerer <gerg@uclinux.org>

Thanks. The updated patch below.

baruch
