From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 24 Feb 2012 14:34:15 +0000
Subject: [PATCH] regulator: twl6030: add support for vdd1, vdd2 and vdd3
 regulators
In-Reply-To: <1330093512.4102.552.camel@sokoban>
References: <1329995109-4795-1-git-send-email-t-kristo@ti.com>
 <20120223153422.GF4553@opensource.wolfsonmicro.com>
 <1330076289.4102.517.camel@sokoban>
 <20120224114940.GB5450@opensource.wolfsonmicro.com>
 <1330089398.4102.539.camel@sokoban>
 <20120224132408.GF5450@opensource.wolfsonmicro.com>
 <1330091765.4102.547.camel@sokoban>
 <20120224140109.GG5450@opensource.wolfsonmicro.com>
 <1330093512.4102.552.camel@sokoban>
Message-ID: <20120224143415.GL5450@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 04:25:12PM +0200, Tero Kristo wrote:

> Still, setting selector in this case does nothing, as it is immediately
> overwritten by the regulator core by -1. This looks like a perfectly
> acceptable way to implement a regulator, as everything checks for the
> presence of list_voltage anyway.

Ah, so it is - we're fixing things up in the core.  I'd forgotten we did
that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120224/b2efbe28/attachment.sig>
