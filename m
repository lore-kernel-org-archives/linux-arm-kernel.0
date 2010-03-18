From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Mar 2010 13:23:59 +0000
Subject: devicetree in arm
In-Reply-To: <fa686aa41003180614g574b9d91o5926f94a59ad5ec9@mail.gmail.com>
References: <dac45061003180504k49a9f303y4329530a5b475108@mail.gmail.com>
	<fa686aa41003180614g574b9d91o5926f94a59ad5ec9@mail.gmail.com>
Message-ID: <20100318132358.GE19544@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 18, 2010 at 07:14:05AM -0600, Grant Likely wrote:
> ARM device tree support is very much in flux, and that particular
> branch gets rebased a lot as device tree code from Sparc, Microblaze
> and Powerpc is merged into drivers/of.  I may have ended up pushing
> out to test-devicetree without the ARM patches applied.  I'll look at
> it today, make sure the ARM stuff is all there, and then push it out
> again.
> 
> Note however that this is only very basic support.  It doesn't yet
> have the code needed to register devices and drivers from device tree
> data.  That will be coming real-soon-now.

Is someone going to do a device tree example port to a 'real' platform
rather than simple the ARM evaluation boards?

As I've said previously, I'm not going to accept device tree stuff until
I see a working implementation on a set of real platforms.
