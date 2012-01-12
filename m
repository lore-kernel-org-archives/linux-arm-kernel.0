From: w.sang@pengutronix.de (Wolfram Sang)
Date: Thu, 12 Jan 2012 12:00:11 +0100
Subject: mxs-auart serial driver DMA support?
In-Reply-To: <4F0EB5BB.1060008@bluegiga.com>
References: <4F0E7EB0.2060906@bluegiga.com>
 <20120112094244.GA2775@pengutronix.de>
 <4F0EB5BB.1060008@bluegiga.com>
Message-ID: <20120112110010.GF2775@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2012 at 12:28:11PM +0200, Lauri Hintsala wrote:
> On 01/12/2012 11:42 AM, Wolfram Sang wrote:
> >
> >>Any plans to add DMA support for mxs-auart serial driver? I noticed
> >>it is impossible to archive full 3.25 Mbs speed with current one.
> >
> >No plans from our side, currently.
> 
> OK, AUART works fine with 115200 bps but over that it loose data
> randomly. I have seen fifo overrun errors during receiving data with
> 1Mbs and over. So current driver is unuseful with higher baud rates.

Care to send a patch adding this information to Kconfig help text and/or
source code? Would be much more useful there, I think.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120112/a517d75b/attachment.sig>
