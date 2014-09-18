From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 18 Sep 2014 16:54:42 +0100
Subject: [PATCH v4 18/18] Documentation: ACPI for ARM64
In-Reply-To: <20140917234036.GC2464@xora-yoga-13>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <20140917014410.GC31214@srcf.ucam.org>
 <20140917160508.GA2464@xora-yoga-13>
 <201409180122.10631.arnd@arndb.de>
 <20140917234036.GC2464@xora-yoga-13>
Message-ID: <20140918155439.GA25330@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 18, 2014 at 12:40:36AM +0100, Graeme Gregory wrote:
> On Thu, Sep 18, 2014 at 01:22:10AM +0200, Arnd Bergmann wrote:
> > On Wednesday 17 September 2014, Graeme Gregory wrote:
> > > It sounds like from the discussions in other threads that ARM64 should
> > > be following x86 and re-using DT bindings here. In which case there is
> > > not need to submit things to UEFI organisation.
> > > 
> > > What I got a little lost in has there been a formal decision about DT
> > > bindings in _DSD?
> > 
> > I think this is a discussion that still needs to happen: either we should
> > recommend everyone to use _DSD in favor of the alternatives, or we
> > should prohibit the use of _DSD. I have heard arguments both ways, but
> > hopefully we can find an easy answer.
> 
> This discussion is just not going to happen until people at @redhat.com
> and people who have currently announced/released hardware are actually
> willing to start talking about it.

OTOH, there doesn't seem to be any urgency for merging arm64 ACPI
support, so this discussion can wait ;).

> Id love to be able to put my foot down and ban the use of _DSD for
> servers but I suspect that will not happen.

And the alternative would be hard-coded platform specific configuration
(or we assume that such configuration isn't needed)?

-- 
Catalin
