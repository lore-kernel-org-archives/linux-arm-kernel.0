From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Oct 2017 11:52:27 +0100
Subject: [PATCH v3 0/2] arm: remove cpu_efficiency
In-Reply-To: <20171024102718.16113-1-dietmar.eggemann@arm.com>
References: <20171024102718.16113-1-dietmar.eggemann@arm.com>
Message-ID: <20171024105227.GD20805@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 24, 2017 at 11:27:16AM +0100, Dietmar Eggemann wrote:
> With the dt related patches for exynos and renesas now in the
> appropriated for-next branches for v4.15 there are no Cortex-A15/A7 arm
> big.LITTLE systems left relying on the 'cpu_efficiency/clock-frequency
> dt property' based solution anymore.

This is way too early to remove support for something that has been
in place since 2012.  As you've just shown, people are using it with
DT files today.  We don't know how long people will persist using
older files, and we don't know whether there are DT files out in the
wild that we don't know about.

Our general rule is that we maintain compatibility for older DT.

NAK.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
