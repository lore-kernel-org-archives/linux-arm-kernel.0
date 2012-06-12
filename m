From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jun 2012 08:09:00 +0000
Subject: [PATCH v2] arm: Add basic support for new Marvell Armada 370 and
 Armada XP SoC
In-Reply-To: <4FD658C2.4030503@redhat.com>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
 <4FD658C2.4030503@redhat.com>
Message-ID: <201206120809.01067.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 June 2012, David Marlin wrote:
> I noticed that you are using mach-mvebu in these patches.  I have seen 
> these machines referred to as 'armada', 'axp', 'armadaxp', etc.  Will 
> 'mvebu' be the official machine name to use for these systems?  I'm 
> looking for a 'name' to identify the common kernel for these systems. 
> For reference, the names of the ARM kernels we are currently building in 
> Fedora include: 'highbank', 'imx', 'kirkwood', 'omap', and 'tegra'.

The 'mvebu' family will include the 'kirkwood' parts you are already building
for along with the 'orion' and 'mv78xx0' when building for ARMv5, and
will include the existing 'dove' soc in addition to the new Armada 370 and
Armada XP when building for ARMv7.

All the other ones you are currently building are ARMv6 or ARMv7 based, so
I'd hope that in the long run (maybe the end of the year), we can get to
the point of building them into a common kernel.

	Arnd
