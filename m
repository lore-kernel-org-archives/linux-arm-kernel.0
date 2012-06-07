From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 8 Jun 2012 07:36:11 +0800
Subject: Freescale fec.c driver breakage
In-Reply-To: <4FCF0994.4040902@snapgear.com>
References: <4FCC3CB4.5030107@snapgear.com> <4FCE088D.1060604@snapgear.com>
 <20120605134116.GY23408@opensource.wolfsonmicro.com>
 <201206050735.00458.sfking@fdwdc.com>
 <4FCF0994.4040902@snapgear.com>
Message-ID: <20120607233609.GR14525@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 06, 2012 at 05:41:08PM +1000, Greg Ungerer wrote:

> Most of the older ones don't. Most of the older parts that have a FEC
> core have a single clock-in for the chip, possibly a PLL and often a
> fixed divisor for distribuion to all on-chip peripherals. I have seen it
> named various names, 'bclko', 'mclk', "fsys/2", nothing seems consistent.

> I think very generic namse might be the best solution here.

Bear in mind that the IP level names shouldn't need to correspond to the
names used in the overall system integration.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120608/04d951c6/attachment.sig>
