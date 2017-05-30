From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 May 2017 15:34:45 +0200
Subject: [PATCH 4/6] irqchip: irq-mvebu-icu: new driver for Marvell ICU
In-Reply-To: <20170530132735.GA21646@lunn.ch>
References: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1496135772-20694-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170530121907.GO22219@n2100.armlinux.org.uk>
 <20170530143350.6f8563c1@free-electrons.com>
 <20170530125643.GQ22219@n2100.armlinux.org.uk>
 <20170530132735.GA21646@lunn.ch>
Message-ID: <20170530153445.17c98b62@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 30 May 2017 15:27:35 +0200, Andrew Lunn wrote:

> > Given the number of patch sets that I have, that is simply an
> > impossibility to do on a continual basis - I have close to 500
> > patches, and there's simply no way to post that number of patches.  
> 
> So you don't expect to every have your 500 patches merged?
> 
> What might help is that you ask for help getting them merged. I know
> of at least 4 groups of people interested in your devlink and 10G PHY
> code. If you handed those patches over to these people, i'm sure we
> could find somebody to post them to the list, deal with the feedback,
> etc, to get them merged. It just needs you to say it is O.K. for
> somebody to take patches from your git tree.
> 
> You are great at writing new code, but terrible at getting it
> merged. So try to find somebody who you trust, who you can hand the
> patches over to, to do the merge work.

For the record: my colleague Boris Brezillon had some time available to
work on SFP support and was willing to help Russell moving things
forward. So he talked with Russell, who as usual said "I'm working on
it".

That was in February. We're in May. Nothing happened.

So I can only agree with Andrew here: Russell you're doing awesome
technical work in terms of writing code, but you don't know how to get
it merged, and you block people trying to help you. So don't be
surprised if other people reinvent the same wheel and get it merged
before you.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
