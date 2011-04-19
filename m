From: thomas.ab@samsung.com (Thomas Abraham)
Date: Tue, 19 Apr 2011 14:10:00 +0530
Subject: Cleanup Samsung stuff
In-Reply-To: <20110419080307.GA26650@sirena.org.uk>
References: <012801cbfe33$a76fa490$f64eedb0$%kim@samsung.com>
	<20110419080307.GA26650@sirena.org.uk>
Message-ID: <BANLkTim2VJBoO-otakfVQaYsXLTyM91jsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 1:33 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Tue, Apr 19, 2011 at 10:46:47AM +0900, Kukjin Kim wrote:
>
>> - Device tree (with Linaro)
>
> What is going on with device tree? ?I've asked a couple of times about
> this in the other thread but I'm still not clear where the code is or
> what could usefully be done with it.

The initial work on Samsung's s5pv310 is available at
http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-February/004350.html

It is based on Grant's tree.
git://git.secretlab.ca/git/linux-2.6 devicetree/test

Currently I am working on supporting clkdev and Jeremy's common clock
for all of Samsung's platforms and then continue with the device tree
support for s5pv310.

Regards,
Thomas.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
