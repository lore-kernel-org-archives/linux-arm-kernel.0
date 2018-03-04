From: baruch@tkos.co.il (Baruch Siach)
Date: Sun, 4 Mar 2018 14:13:24 +0200
Subject: [PATCH 2/2] ARM: dts: armada388-clearfog: add SFP module support
In-Reply-To: <E1eqhha-0004l3-Rd@rmk-PC.armlinux.org.uk>
References: <20180227160135.GU9418@n2100.armlinux.org.uk>
 <E1eqhha-0004l3-Rd@rmk-PC.armlinux.org.uk>
Message-ID: <20180304121324.ut3d3i2vpdopae7o@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Tue, Feb 27, 2018 at 04:02:02PM +0000, Russell King wrote:
> Add SFP module support for Clearfog using the SFP phylink support.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Tested-by: Baruch Siach <baruch@tkos.co.il>

Tested on Clearfog base with kernel version 4.16-rc3. The SFP module is 1G 
copper Linktel LX1801CNR.

ethtool output:

	Identifier                                : 0x03 (SFP)
	Extended identifier                       : 0x04 (GBIC/SFP defined by 2-wire interface ID)
	Connector                                 : 0x00 (unknown or unspecified)
	Transceiver codes                         : 0x00 0x00 0x00 0x08 0x00 0x00 0x00 0x00
	Transceiver type                          : Ethernet: 1000BASE-T
	Encoding                                  : 0x01 (8B/10B)
	BR, Nominal                               : 1300MBd
	Rate identifier                           : 0x00 (unspecified)
	Length (SMF,km)                           : 0km
	Length (SMF)                              : 0m
	Length (50um)                             : 0m
	Length (62.5um)                           : 0m
	Length (Copper)                           : 100m
	Length (OM3)                              : 0m
	Laser wavelength                          : 0nm
	Vendor name                               : LINKTEL
	Vendor OUI                                : 00:00:00
	Vendor PN                                 : LX1801CNR
	Vendor rev                                : 1.0
	Option values                             : 0x00 0x10
	Option                                    : TX_DISABLE implemented
	BR margin, max                            : 0%
	BR margin, min                            : 0%
	Vendor SN                                 : 1172623927
	Date code                                 : 170628

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
