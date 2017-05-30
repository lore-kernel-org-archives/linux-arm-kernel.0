From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 May 2017 16:26:13 +0200
Subject: [PATCH 4/6] irqchip: irq-mvebu-icu: new driver for Marvell ICU
In-Reply-To: <20170530134226.GR22219@n2100.armlinux.org.uk>
References: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1496135772-20694-5-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170530121907.GO22219@n2100.armlinux.org.uk>
 <20170530143350.6f8563c1@free-electrons.com>
 <20170530125643.GQ22219@n2100.armlinux.org.uk>
 <20170530132735.GA21646@lunn.ch>
 <20170530134226.GR22219@n2100.armlinux.org.uk>
Message-ID: <20170530162613.7cad95b6@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 30 May 2017 14:42:26 +0100, Russell King - ARM Linux wrote:

> As I've repeatedly explained - and it's called phylink, not devlink -
> the SFP support is not ready due to the SFP+ stuff needing a complete
> rewrite of that code, which has been delayed because of delays on
> SolidRun's side to provide SFP+ hardware.

This is a very good illustration of why your contribution process
doesn't work: you wait to have the full-featured perfect solution
before submitting anything. Due to that, either you have huge series
that nobody ever reviews, or you never reach the point were things are
perfect enough to your taste, and therefore nothing ever gets submitted.

Don't be surprised if others take the lead, work on the same topics and
submit patches.

> Much of the changes for that happened during the last month, but are
> currently rather dirty and incomplete, but are in a working state.
> As you know, I had been pushing out the 10G PHY changes as quickly as
> netdev copes with them during the previous kernel cycle.  The rate of
> patch merging was completely insufficient to get the 10G support into
> netdev - with it taking a week or longer between patches posted and
> the merge happening.

A week is *nothing*. On other topics, you have to wait months to get
reviews from maintainers, and still people manage to get things merged
upstream.

> > You are great at writing new code, but terrible at getting it
> > merged.  
> 
> Yes, because I find it very very time consuming and frustrating to
> deal with other people - it's really not easy.

Fair enough. But in this case, please stop complaining when other
people are willing to take the time and effort to submit patches.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
