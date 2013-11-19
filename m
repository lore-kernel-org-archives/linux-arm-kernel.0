From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 19 Nov 2013 13:54:32 +0000
Subject: ARM topic: Is DT on ARM the solution,
 or is there something better?
In-Reply-To: <20131118124518.GA16735@n2100.arm.linux.org.uk>
References: <52644A9E.3060007@wwwdotorg.org> <20131020231134.GR25034@n2100.
 arm.linux.org.uk> <20131021083242.GB30088@pengutronix.de> <20131021084854.
 GV25034@n2100.arm.linux.org.uk> <20131021092730.GF30088@pengutronix.de> <
 CAF6AEGtt_2sStiZCNBp9btxevWghSwLZZBdN6ir8eUpX1FXrCQ@mail.gmail.com> <
 20131024072811.GS30088@pengutronix.de> <
 CAF6AEGuEho9Ms7ifTE-EmBoQ-=_AXgvGcJxi5qEC0vsZ+H9C+A@mail.gmail.com> <
 20131118124518.GA16735@n2100.arm.linux.org.uk>
Message-ID: <20131119135432.9DD0AC4079D@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Nov 2013 12:45:19 +0000, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Thu, Oct 24, 2013 at 05:21:54PM -0400, Rob Clark wrote:
> > ahh, ok.  Yeah, we do need some way to make this easier, as it is a
> > too-common pattern.  I do think we do need a way to know if something
> > is missing because it isn't there vs it hasn't been probed yet.  Ie.
> > late_initcall() is not the awesome solution.
> 
> On this topic, I now have a solution to this which is not DRM specific,
> nor is it DT specific.
> 
> It's a core piece of code which gathers up the struct device pointers,
> and a callback for the master device to assemble the components and
> indicate when the master is complete.

That's pretty clean. I think that will work nicely.

g.
