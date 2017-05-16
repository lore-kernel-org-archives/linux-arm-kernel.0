From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 16 May 2017 13:52:17 +0200
Subject: [PATCH 1/2] arm64: marvell: dts: fill MachiatoBin board
 description
In-Reply-To: <20170516100236.GA22219@n2100.armlinux.org.uk>
References: <1494890913-8360-1-git-send-email-mw@semihalf.com>
 <1494890913-8360-2-git-send-email-mw@semihalf.com>
 <20170515232825.GX22219@n2100.armlinux.org.uk>
 <CAPv3WKdULNEDcqJ=qsBEAApaJNiyJXAw6ZG=Ejd8TxE6LJkYLw@mail.gmail.com>
 <20170516095027.GZ22219@n2100.armlinux.org.uk>
 <20170516115535.2faf86ec@free-electrons.com>
 <20170516100236.GA22219@n2100.armlinux.org.uk>
Message-ID: <20170516135217.016717e7@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 16 May 2017 11:02:37 +0100, Russell King - ARM Linux wrote:

> > Correct, but Marcin has submitted patches, and you haven't.  
> 
> As I said, give me a friggin chance.  You know full well that I've been
> working on this, working with you and submitting patches.

Correct. But Marcin patches are small and easy, they are ready today,
and they bring useful benefits for users. You're trying to provide a
full blown solution, which ultimately is good, but in the mean time it
would be good to enable the features that already work today.

> > I believe if you say that, it's because you don't know how much work
> > Marcin is doing behind the scenes on supporting Marvell platforms, and
> > not only at the Linux kernel level.  
> 
> Maybe Marcin doesn't know how much work I'm doing supporting this board?

Marcin also knows you're doing some work on this board.

> > Gr?gory Clement has been working on this, and he has a patch series
> > almost ready to submission.  
> 
> You've seen my patches, because I've sent them to you in the past.
> 
> > > The code which I have in my tree is correct for the Armada 8k hardware
> > > (which has some weirdness about which gpios on each CP110 appear to the
> > > external world - some are used for inter-CP110 communication and must
> > > not be exposed) so any additional work should be based on the code in
> > > my tree.  
> > 
> > No, there is no rule like this in the kernel community. Whatever is in
> > your private tree does not matter. Until it gets submitted, it doesn't
> > exist, and nobody is forced to base its work on top of your
> > unknown/private trees.  
> 
> It _has_ been submitted - a few months ago - so you're talking rubbish
> here.  You just need to check your mailbox.

Could you please avoid insults? It doesn't bring any benefit.

And in addition, you're deforming reality. The reality is:

 - The patches you posted are related to pinmux/gpio support. This is
   one thing.

 - The patches posted by Marcin do not touch anything pinmux/gpio
   related.

Therefore, there is no reason to not merge Marcin patches, because they
do not conflict with anything you have already posted. If Marcin
patches were complicated and causing severe conflicts with what you
already have, I would definitely understand your arguments. But here,
Marcin patches are simply and easy DT patches, rebasing on top of them
and fixing the minor conflicts will be trivial.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
