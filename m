From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 14 Oct 2018 14:33:53 +0100
Subject: [PATCH V4 2/15] KVM/MMU: Add tlb flush with range helper function
In-Reply-To: <CAOLK0pzHAc1ipDbd3Trg2W_Gb_DxdEKM2ML5Fk09u0-O8y6UAg@mail.gmail.com>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
 <20181013145406.4911-3-Tianyu.Lan@microsoft.com>
 <4D709C3A-A91C-4CA7-922A-E77618EF21B4@oracle.com>
 <alpine.DEB.2.21.1810141014350.1438@nanos.tec.linutronix.de>
 <20181014092734.GV30658@n2100.armlinux.org.uk>
 <20181014093541.GW30658@n2100.armlinux.org.uk>
 <CAOLK0pzHAc1ipDbd3Trg2W_Gb_DxdEKM2ML5Fk09u0-O8y6UAg@mail.gmail.com>
Message-ID: <20181014133352.GX30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 14, 2018 at 09:21:23PM +0800, Tianyu Lan wrote:
> Sorry to confuse your. I get from CCers from get_maintainer.pl script.

Unfortunately you seem to have made a mistake.  My email address is
'linux at armlinux.org.uk' not 'linux at armlinux.org'.  There is no
'linux at armlinux.org' in MAINTAINERS, yet your emails appear to be
copied to this address.

Consequently, if it was your intention to copy me with the entire
series, that didn't happen.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
