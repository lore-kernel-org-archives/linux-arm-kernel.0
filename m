From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 16 May 2017 13:13:55 +0100
Subject: [PATCH 1/2] arm64: marvell: dts: fill MachiatoBin board
 description
In-Reply-To: <20170516135217.016717e7@free-electrons.com>
References: <1494890913-8360-1-git-send-email-mw@semihalf.com>
 <1494890913-8360-2-git-send-email-mw@semihalf.com>
 <20170515232825.GX22219@n2100.armlinux.org.uk>
 <CAPv3WKdULNEDcqJ=qsBEAApaJNiyJXAw6ZG=Ejd8TxE6LJkYLw@mail.gmail.com>
 <20170516095027.GZ22219@n2100.armlinux.org.uk>
 <20170516115535.2faf86ec@free-electrons.com>
 <20170516100236.GA22219@n2100.armlinux.org.uk>
 <20170516135217.016717e7@free-electrons.com>
Message-ID: <20170516121355.GD22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 16, 2017 at 01:52:17PM +0200, Thomas Petazzoni wrote:
> Hello,
> 
> On Tue, 16 May 2017 11:02:37 +0100, Russell King - ARM Linux wrote:
> 
> > > Correct, but Marcin has submitted patches, and you haven't.  
> > 
> > As I said, give me a friggin chance.  You know full well that I've been
> > working on this, working with you and submitting patches.
> 
> Correct. But Marcin patches are small and easy, they are ready today,
> and they bring useful benefits for users. You're trying to provide a
> full blown solution, which ultimately is good, but in the mean time it
> would be good to enable the features that already work today.

Unfortunately, they don't all work - see my other email.  The SD slot
is non-functional with the latest sdhci-xenon driver.  The previous
revision worked fine.

> > > I believe if you say that, it's because you don't know how much work
> > > Marcin is doing behind the scenes on supporting Marvell platforms, and
> > > not only at the Linux kernel level.  
> > 
> > Maybe Marcin doesn't know how much work I'm doing supporting this board?
> 
> Marcin also knows you're doing some work on this board.

Right, so this is all one way.  It would have been nice to have had a
heads-up or something, which would have aided co-operation instead of
confrontation.

> > It _has_ been submitted - a few months ago - so you're talking rubbish
> > here.  You just need to check your mailbox.
> 
> Could you please avoid insults? It doesn't bring any benefit.
> 
> And in addition, you're deforming reality. The reality is:
> 
>  - The patches you posted are related to pinmux/gpio support. This is
>    one thing.

The point you replied to was about pinmux/gpio, not about Marcin's patch.
So you trying to twist this back to Marcin's patches is unhelpful.
Stop being a problem.

> Therefore, there is no reason to not merge Marcin patches, because they
> do not conflict with anything you have already posted.

Except that the SD slot is broken.

Anyone can produce and post untested patches, but that's not really
the point of kernel development.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
