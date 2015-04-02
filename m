From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Apr 2015 16:25:10 +0100
Subject: [PATCH] ARM: mvebu: use 0xf1000000 as internal registers on
 Armada 370 DB
In-Reply-To: <20150402170253.70e951bd@free-electrons.com>
References: <1427966184-8288-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <2321040.CmsL1gluUd@wuerfel>
 <20150402153650.2cc9c3d7@free-electrons.com>
 <2515980.d69ggAvHPo@wuerfel>
 <20150402161626.182e267d@free-electrons.com>
 <20150402144823.GJ24899@n2100.arm.linux.org.uk>
 <20150402170253.70e951bd@free-electrons.com>
Message-ID: <20150402152510.GK24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 02, 2015 at 05:02:53PM +0200, Thomas Petazzoni wrote:
> Dear Russell King - ARM Linux,
> 
> On Thu, 2 Apr 2015 15:48:24 +0100, Russell King - ARM Linux wrote:
> 
> > Wrong.  It's Arnd's responsibility to make sure that platform maintainers
> > don't do stupid things like change the DT in incompatible ways which
> > break lots of people's setups.
> > 
> > However, it is _your_ responsibility as the platform maintainer to place
> 
> I am _not_ a platform maintainer. But thanks for supposing so :-)

Right, that's because your statements in your emails are ambiguous.

> > sufficient information into the commit message that explains why the
> > change is necessary, and justifies the change.  Much of what you've said
> > in these follow-on emails should have been in the original message to
> > explain what the situation is, and why the change is appropriate.
> > 
> > I'm willing to bet that if the commit description had explained it
> > properly, Arnd would have applied it by now.
> 
> Agreed that the commit message could have been better. Though the
> commit message is sufficiently clear for the platform maintainers to
> understand, since they have all the background about the platform
> needed to understand it. I don't think all commit messages in the
> kernel are meant to be understood by developers having no knowledge of
> the area touched by the patch.

Wrong.  The commit message is supposed to be there so that everyone
can understand why the commit is necessary.  For example, you will
often see Andrew Morton regularly complaining about the poor quality
of commit messages on patches he ends up dealing with, and they're
always the same kinds of issues: lack of understandable justification
for the patch.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
