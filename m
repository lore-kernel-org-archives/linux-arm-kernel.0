From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 30 Nov 2011 13:21:43 -0800
Subject: [PATCH v3 4/5] ARM: vexpress: Initial RS1 memory map support
In-Reply-To: <20111130204805.GA5698@sirena.org.uk>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <1322579473-8804-5-git-send-email-pawel.moll@arm.com>
 <20111130153749.GE2045@localhost.localdomain>
 <1322673302.3180.25.camel@hornet.cambridge.arm.com>
 <20111130175410.GJ2045@localhost.localdomain>
 <alpine.LFD.2.02.1111301522340.2357@xanadu.home>
 <20111130204805.GA5698@sirena.org.uk>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF174FDAFF9B@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote at Wednesday, November 30, 2011 1:48 PM:
> On Wed, Nov 30, 2011 at 03:43:50PM -0500, Nicolas Pitre wrote:
> 
> > annoying.  If nothing moves I might just go ahead with those changes and
> > simply rip the uImage make target out of the kernel as well.  Maybe the
> > inconvenience will be a sufficient incentive for people to lobby proper
> > u-Boot support.  And it is not like if the u-Boot patches didn't exist
> 
> Oh, dear.  Any pointers to the discussions on the u-boot side?

The most recent patch is at:

http://www.mail-archive.com/u-boot at lists.denx.de/msg69105.html

Earlier versions are at:

http://www.mail-archive.com/u-boot at lists.denx.de/msg68907.html
http://www.mail-archive.com/u-boot at lists.denx.de/msg67647.html
http://www.mail-archive.com/u-boot at lists.denx.de/msg66537.html
http://www.mail-archive.com/u-boot at lists.denx.de/msg65837.html
http://www.mail-archive.com/u-boot at lists.denx.de/msg64721.html
http://www.mail-archive.com/u-boot at lists.denx.de/msg64237.html

-- 
nvpublic
