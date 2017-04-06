From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 06 Apr 2017 10:47:57 +0200
Subject: [PATCH 1/3] ARM: dts: rockchip: Add support for phyCORE-RK3288 SoM
In-Reply-To: <1872284.4EEa8KbvLF@phil>
References: <1491214985-18331-1-git-send-email-w.egorov@phytec.de>
 <1872284.4EEa8KbvLF@phil>
Message-ID: <11932726.5xfcEjvM7n@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 6. April 2017, 10:30:46 CEST schrieb Heiko Stuebner:
> Am Montag, 3. April 2017, 12:23:03 CEST schrieb Wadim Egorov:
> > The phyCORE-RK3288 is a SoM (System on Module) containing a RK3288 SoC.
> > The module can be connected to different carrier boards.
> > It can be also equipped with different RAM, SPI flash and eMMC variants.
> > 
> > The Rapid Development Kit option is using the following setup:
> >   - 1 GB DDR3 RAM (2 Banks)
> >   - 1x 4 KB EEPROM
> >   - DP83867 Gigabit Ethernet PHY
> >   - 16 MB SPI Flash
> >   - 4 GB eMMC Flash
> > 
> > Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> 
> applied for 4.12 with the following minor changes:

had to unapply again ... can you please check the license of the files

They're currently GPL2-only, while we use a combined GPL+X11 license
everywhere else. See every other Rockchip dts (and even most other
socs) for reference.

Thanks
Heiko
