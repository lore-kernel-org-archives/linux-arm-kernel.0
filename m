From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jul 2012 20:46:05 +0100
Subject: [PATCH V2 5/6] x86: add CONFIG_ARM_AMBA, selected by STA2X11
In-Reply-To: <20120703132641.GA28437@mail.gnudd.com>
References: <201207031319.40884.arnd@arndb.de>
 <2b797c83-6a3c-4051-841a-a4cfa9d1cae1@email.android.com>
 <20120701104401.GA4352@mail.gnudd.com>
 <20120703130042.GA10007@mail.gnudd.com>
 <20120703132641.GA28437@mail.gnudd.com>
Message-ID: <20120703194605.GB26355@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2012 at 03:26:41PM +0200, Alessandro Rubini wrote:
> I already have this in place for other drivers that I'm going to use
> with the pci-amba bridge. They have already been picked up by Rusell,
> but they are not in linux-next yet.  So maybe other people have more
> errors than me related to sizes.h, but this for mmci is trivial with
> the other stuff in place.
> 
> Ok for the rest, I'll submit a patch set following your suggestions
> when the other sizes.h stuff reaches linux-next.

I've not pushed them into linux-next, because my nightly test builds
for Versatile were failing due to the LEDS stuff in arm-soc, and
that's one of the platforms your patches have the potential to affect.

Now that the LEDS stuff has been dropped out of arm-soc, the build
results are a lot more promising, and I'm now happier to move them
into linux-next.
