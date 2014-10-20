From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Mon, 20 Oct 2014 17:24:25 +0200
Subject: [GIT PULL] dts, kbuild: Implement support for dtb vendor subdirs
In-Reply-To: <CAM4voakQnY1JMnjrXfTSNTyzA6_f6jtUgJZXXz2N0YRjq3kXRg@mail.gmail.com>
References: <1409899692-1455-1-git-send-email-rric@kernel.org>
 <CAL1qeaGCeRyeKLo70E264bZcamOfBKoN9Y8_NDCjV5j4DoOw1Q@mail.gmail.com>
 <20140919123056.GC20170@rric.localhost>
 <20140919140856.GG2295@e104818-lin.cambridge.arm.com>
 <20140923112619.GG20170@rric.localhost>
 <20141002150804.GP20170@rric.localhost>
 <CAM4voakQnY1JMnjrXfTSNTyzA6_f6jtUgJZXXz2N0YRjq3kXRg@mail.gmail.com>
Message-ID: <20141020152425.GY31556@rric.localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.10.14 19:26:32, Abhilash Kesavan wrote:

> >> > > > > Robert Richter (6):
> >> > > > >   dts, arm64: Add dtbs_install make target
> >> > > > >   dts, kbuild: Factor out dtbs install rules to Makefile.dtbinst
> >> > > > >   dts, arm/arm64: Remove dtbs build rules in sub-makes
> >> > > > >   dts, kbuild: Implement support for dtb vendor subdirs
> >> > > > >   dts, arm64: Move dts files to vendor subdirs
> >> > > > >   dts, arm: Remove $(MACHINE) variable from dtbs make recipes

> > you may want to pull from here alternatively.
> 
> I have been using your patchset as the base for my new arm64 SoC
> support (http://www.spinics.net/lists/linux-samsung-soc/msg37047.html).
> Are you planning to rebase and send this again as some of the patches
> did not apply cleanly for me on linux-next.

Yes, I will rebase it and resend the pull request this week.

-Robert
