From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jan 2014 14:14:46 +0000
Subject: [PATCH RFC 26/46] drivers/base: provide an infrastructure for
 componentised subsystems
In-Reply-To: <2450832.kBuTIAzyCY@vostro.rjw.lan>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <3242371.eHgoTRi3y3@vostro.rjw.lan>
 <20140103121812.GJ7383@n2100.arm.linux.org.uk>
 <2450832.kBuTIAzyCY@vostro.rjw.lan>
Message-ID: <20140103141446.GL7383@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 02:24:26PM +0100, Rafael J. Wysocki wrote:
> On Friday, January 03, 2014 12:18:13 PM Russell King - ARM Linux wrote:
> > I'm not sure what I'm looking for.  I've tried looking at the results of
> > searching your linux-next branch for "container" but I don't see
> > anything implementing similar functionality to the patch I've sent.
> > 
> > https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/log/?h=linux-next&qt=grep&q=container
> 
> I've just set up the acpi-hotplug branch in linux-pm.git (because I often
> rebase the linux-next one).
> 
> The only commit in that branch you need to look at is this one:
> 
> http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=acpi-hotplug&id=caa73ea158de9419f08e456f2716c71d1f06012a
> 
> but quite frankly I'm not sure how it is related to your work. :-)

Yes, I'm coming to that conclusion as well.  It looks like your "containers"
aren't about collecting up several individual component devices into one
super-device and probing the appropriate subsystem when all components are
known.

Confused why Greg is pointing me at your patches.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
