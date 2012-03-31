From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 31 Mar 2012 14:45:16 +0100
Subject: [PATCH 2/2] regulator: rename function regulator_register_fixed
In-Reply-To: <20120331125440.GA2395@S2101-09.ap.freescale.net>
References: <1333182812-423-1-git-send-email-shawn.guo@linaro.org>
 <1333182812-423-2-git-send-email-shawn.guo@linaro.org>
 <20120331102507.GB3163@opensource.wolfsonmicro.com>
 <20120331125440.GA2395@S2101-09.ap.freescale.net>
Message-ID: <20120331134515.GB5012@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 31, 2012 at 08:54:43PM +0800, Shawn Guo wrote:
> On Sat, Mar 31, 2012 at 11:25:08AM +0100, Mark Brown wrote:

> > There's no harm in using it for regulators that physically exist if
> > nothing cares about any of the information it can't provide

> I do not think it's practical for physical regulator to use the
> function, since the function forces microvolts to be 0.

Yeah, but it depends if anyone actually cares what the voltage is - most
consumers never look to see what the voltage is because they have no
reason to care.  The lack of naming is more of an issue really.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120331/fd870d51/attachment.sig>
