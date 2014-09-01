From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 1 Sep 2014 16:03:20 +0200
Subject: [Patch v3] 0/7] Remove mach-kirkwood
In-Reply-To: <1997148.5Fa3W8ZmXx@vostro.rjw.lan>
References: <1409417172-6846-1-git-send-email-andrew@lunn.ch>
 <1997148.5Fa3W8ZmXx@vostro.rjw.lan>
Message-ID: <20140901140320.GE11312@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 03:56:43PM +0200, Rafael J. Wysocki wrote:
> On Saturday, August 30, 2014 06:46:05 PM Andrew Lunn wrote:
> > This is mostly a resend of these patches, removing mach-kirkwood.  Not
> > all maintainers picked up there patches, which has resulted in some
> > dead kernel configuration in v3.17-rcX.
> > 
> > The patch set has been rebased on v3.17-rc2, and it is intended that
> > Jason Cooper will submit them for inclusion in an RC. Subsystem
> > maintainers do not need to do anything.
> > 
> > The last patch "cpufreq: Remove ARCH_KIRKWOOD dependency" is new,
> > since what it is removing was added during v3.16-rcX. It follows the
> > pattern of all the other patches.
> > 
> > Andrew Lunn (7):
> >   cpuidle: kirkwood: Remove ARCH_KIRKWOOD dependency
> >   ata: Remove ARCH_KIRKWOOD dependency
> >   thermal: Remove ARCH_KIRKWOOD dependency
> >   leds: Remove ARCH_KIRKWOOD dependency
> >   rtc: Remove ARCH_KIRKWOOD dependency
> >   watchdog: Remove ARCH_KIRKWOOD dependency
> >   cpufreq: Remove ARCH_KIRKWOOD dependency
> 
> I have no problems with these changes, but what exactly am I supposed to do?

Jason will submit the whole series. So an Acked-by: would be nice.

      Andrew
