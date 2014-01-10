From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Jan 2014 15:11:23 +0000
Subject: [PATCH RFC 26/46] drivers/base: provide an infrastructure for
 componentised subsystems
In-Reply-To: <20140110150702.GA22533@kroah.com>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1Vypo6-0007FF-Lb@rmk-PC.arm.linux.org.uk>
 <20140103031055.GB28751@kroah.com>
 <20140110145444.GE15937@n2100.arm.linux.org.uk>
 <20140110150702.GA22533@kroah.com>
Message-ID: <20140110151123.GG15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 07:07:02AM -0800, Greg Kroah-Hartman wrote:
> On Fri, Jan 10, 2014 at 02:54:44PM +0000, Russell King - ARM Linux wrote:
> > Greg,
> > 
> > Not sure if you saw the outcome to your comment above.  My conclusion
> > was:
> > 
> > "Yes, I'm coming to that conclusion as well.  It looks like your "containers"
> > aren't about collecting up several individual component devices into one
> > super-device and probing the appropriate subsystem when all components are
> > known.
> > 
> > "Confused why Greg is pointing me at your patches."
> 
> Ah, sorry, I missed that in my "catch up on 2 weeks of email" flood.
> 
> > Does this mean you're happy with the patch?
> 
> Well, I will not object to it on the grounds of it being a duplicate of
> Rafael's work now :)
> 
> I'll be glad to consider it on its own, when you feel the series is
> ready to be submitted.

I'll sort out a new set of patches today, along with a branch to pull if
you wish to take them that way.

Thanks.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
