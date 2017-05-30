From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 May 2017 14:33:50 +0200
Subject: [PATCH 4/6] irqchip: irq-mvebu-icu: new driver for Marvell ICU
In-Reply-To: <20170530121907.GO22219@n2100.armlinux.org.uk>
References: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1496135772-20694-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170530121907.GO22219@n2100.armlinux.org.uk>
Message-ID: <20170530143350.6f8563c1@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 30 May 2017 13:19:07 +0100, Russell King - ARM Linux wrote:

> I see we're still duplicating work.
> 
> Yes, I know you'll reply with your "your tree is a private tree" blah
> blah, which is fine if you want to keep re-doing work that others have
> done, but it's incredibly inefficient.
> 
> What you call my private tree is the public ARM git tree - hardly
> private.  It's the one which core ARM changes go through.  The mcbin
> changes are in a separate branch of that tree - hardly private by
> any definition of that term.  It's as private as your own
> free-electrons git tree.

None of the changes in this series are core ARM changes, they touch
Device Tree bindings, irqchip drivers and Device Tree files, none of
which you are maintainer for. Your tree therefore has no higher
authority than any other tree, so using the fact that the core ARM
changes go through your tree as an argument to make people believe your
tree is more important than the contributions from other developers is
a very fallacious argument.

> Given that during the previous rounds I was willing to work with you,
> testing your patches and helping the effort along, I find your attitude
> towards me to be very counter-productive - you seem to have a very big
> NIH problem.
> 
> How about working _together_ sharing the effort, rather than competing?
> 
> I have a 31 patch series in my tree cleaning up the Marvell ICU support
> and adding PM support to the driver - obviously too large to post as-is
> for mainline, but intended for the changes to be reviewable.  Obviously
> that was now a total waste of my time.
> 
> I don't see why I should get involved in the future with Armada 8k, it
> seems whatever effort I put in is wasted.

The problem is that you do tons of work on your side, but never submit
anything. Or when you submit something, it's enormous patch series that
hardly get reviewed because they are too big.

I'm sorry, but we can't wait for you to decide if/when you will send
your patch series. There are some topics that we need to make progress
on, and since you're not sending anything, we have to do it at some
point.

It's exactly the same story as the one with the patches sent by Marcin.
The fact that you have a wonderful set of patches in your private
branch doesn't make the upstream kernel move forward.

Once again: patches not submitted to the mailing list simply don't
exist. So if you continue to keep those huge stack of patches out of
tree and don't submit your work more regularly, in fine-grained patches
series, the situation we have today will continue to happen.

We knew that you were doing some work on the ICU, we knew you were
doing some work on gpio/pinctrl, but none of this was ever submitted.
After several months, it was time to move forward on those topics.

If you want to avoid this situation, submit your patches. Early and
often.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
