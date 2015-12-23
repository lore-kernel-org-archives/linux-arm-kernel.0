From: broonie@kernel.org (Mark Brown)
Date: Wed, 23 Dec 2015 11:37:12 +0000
Subject: next-20151222 build: 3 failures 13 warnings (next-20151222)
In-Reply-To: <20151223034636.GA4569@hector.tx.rr.com>
References: <E1aBIky-0007nI-7t@optimist> <20151222122228.GL5727@sirena.org.uk>
 <20151223034636.GA4569@hector.tx.rr.com>
Message-ID: <20151223113712.GO16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 09:46:36PM -0600, Andy Gross wrote:
> On Tue, Dec 22, 2015 at 12:22:28PM +0000, Mark Brown wrote:

> > which are caused by ab4256cfeab91569 (pinctrl: qcom: pmic-gpio/mpp:
> > of_irq_count() == npins) which adds uses of irq_of_count() but that is
> > not exported so can't be used in modules.  I've just sent a patch adding
> > the export.

> Thanks for fixing that Mark.  I had seen it in the pinctrl builds but hadn't
> gotten the screen time to send in a fix.

It's not fixed, Rob didn't want the export.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151223/5d3fe328/attachment.sig>
