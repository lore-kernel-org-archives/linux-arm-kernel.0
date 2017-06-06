From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Jun 2017 11:13:32 +0100
Subject: [PATCH] arm64: dts: marvell: cp110: add required clocks for mdio
 interface
In-Reply-To: <8760g9ph23.fsf@free-electrons.com>
References: <1496743035-4618-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <8760g9ph23.fsf@free-electrons.com>
Message-ID: <20170606101332.GH4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 06, 2017 at 12:05:24PM +0200, Gregory CLEMENT wrote:
> Hi Thomas,
>  
>  On mar., juin 06 2017, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:
> 
> > From: Russell King <rmk+kernel@armlinux.org.uk>
> >
> > Add the three required clocks for the MDIO interface to be functional
> 
> You should also maybe update the commit log and speaking of two clocks
> as you removed the third one.

When I came up with the patch, I tried to find the minimum number of
clocks, and it seemed to be the three that were in my original commit.

If people are finding that without the patch, they see hangs, but this
iteration of the patch fixes it for them, then that's good.

However, with Thomas' comment after my sign-off, I don't think there's
a need to update the commit text - that comment explains that there
were originally three clocks, and it's now reduced down to two.  It
also indicates that the patch has been modified.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
