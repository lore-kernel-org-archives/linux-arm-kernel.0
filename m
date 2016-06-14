From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Jun 2016 16:52:20 +0100
Subject: Versatile Express randomly fails to boot - Versatile Express to
 be removed from nightly testing
In-Reply-To: <1465918285.2840.41.camel@linaro.org>
References: <55084D99.7050004@arm.com>
 <20150317161748.GZ8656@n2100.arm.linux.org.uk>
 <20150330140333.GJ24899@n2100.arm.linux.org.uk>
 <55196228.5050805@arm.com>
 <20150330150552.GK24899@n2100.arm.linux.org.uk>
 <55196E31.80803@arm.com> <551AD902.9090401@arm.com>
 <20150402141336.GI24899@n2100.arm.linux.org.uk>
 <551D7EAB.1000200@arm.com> <1465918285.2840.41.camel@linaro.org>
Message-ID: <20160614155220.GB1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2016 at 04:31:25PM +0100, Jon Medhurst (Tixy) wrote:
> Using "arm,tag-latency = <2 2 1>" as Russell seemed to indicate [2]
> fixed things for him, also works for me. So should we update mainline
> device-tree with that?

I've proposed that several times, and there seems to be no desire to
do so.  For me, VE CT9x4 no longer boots in my nightly builds, and
my plan at the start of the year was to take it out of both the
nightly builds and the boot tests - no one within ARM seems to have
any interest in the platform.

Having a randomly failing platform due to hardware issues is not
productive to an automated boot test system, so I think we should
(a) remove it from automated testing, and (b) consider deleting
support for it from the kernel tree, as it seems there is little
interest in debugging what's happening.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
