From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 30 Nov 2011 16:38:26 -0500 (EST)
Subject: [PATCH v3 4/5] ARM: vexpress: Initial RS1 memory map support
In-Reply-To: <20111130204805.GA5698@sirena.org.uk>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <1322579473-8804-5-git-send-email-pawel.moll@arm.com>
 <20111130153749.GE2045@localhost.localdomain>
 <1322673302.3180.25.camel@hornet.cambridge.arm.com>
 <20111130175410.GJ2045@localhost.localdomain>
 <alpine.LFD.2.02.1111301522340.2357@xanadu.home>
 <20111130204805.GA5698@sirena.org.uk>
Message-ID: <alpine.LFD.2.02.1111301604230.2357@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Nov 2011, Mark Brown wrote:

> On Wed, Nov 30, 2011 at 03:43:50PM -0500, Nicolas Pitre wrote:
> 
> > annoying.  If nothing moves I might just go ahead with those changes and 
> > simply rip the uImage make target out of the kernel as well.  Maybe the 
> > inconvenience will be a sufficient incentive for people to lobby proper 
> > u-Boot support.  And it is not like if the u-Boot patches didn't exist 
> 
> Oh, dear.  Any pointers to the discussions on the u-boot side?

Certainly.  Many different threads actually.  Here's a few:

http://news.gmane.org/group/gmane.comp.boot-loaders.u-boot/thread=114981

http://news.gmane.org/group/gmane.comp.boot-loaders.u-boot/thread=115774

And this is not the first time this issue has come up:

http://news.gmane.org/group/gmane.comp.boot-loaders.u-boot/thread=83824

http://news.gmane.org/group/gmane.linux.ports.arm.kernel/thread=81546/force_load=t/focus=84138

Yet more u-Boot woes:

http://news.gmane.org/group/gmane.linux.ports.arm.kernel/thread=53973

I'm sure there are others, but that's what I've quickly dug out.


Nicolas
