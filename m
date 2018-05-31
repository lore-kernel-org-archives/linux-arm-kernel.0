From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 May 2018 11:11:34 +0100
Subject: [PATCH v5 10/15] ARM: spectre-v2: warn about incorrect context
 switching functions
In-Reply-To: <b91753a0-7c47-1e46-6884-4643a90afdc7@arm.com>
References: <20180529145320.GJ17671@n2100.armlinux.org.uk>
 <E1fNg1d-00059d-NR@rmk-PC.armlinux.org.uk>
 <86r2lu9yzf.wl-marc.zyngier@arm.com>
 <20180531094922.GQ17671@n2100.armlinux.org.uk>
 <b91753a0-7c47-1e46-6884-4643a90afdc7@arm.com>
Message-ID: <20180531101134.GR17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2018 at 11:07:18AM +0100, Marc Zyngier wrote:
> > I notice that you haven't replied to some of the patches (7 and 8),
> > which makes me think that you have an issue with them - and as tonight
> > is likely the last linux-next before the merge window, we're basically
> > out of time to do another respin if there's something you don't like
> > there and if we want to get them in during the next merge window.
> Patches 7 and 8 didn't compile for me, and I had to fix-up things
> manually in order to test it. Not that it should hold you back from
> merging it.

As noted in a reply to the cover, I made a mistake merging some changes
in that resulted in a simple-to-fix build error (a 'void' instead of a
'bool' return type.)  I wasn't going to send the series out for a third
time on the same day just because of that.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
