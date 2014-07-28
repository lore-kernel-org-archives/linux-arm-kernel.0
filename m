From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jul 2014 13:37:32 +0200
Subject: [PATCH 2/2] ARM: mvebu: Added dts defintion for Lenovo Iomega
 ix4-300d NAS
In-Reply-To: <78E68BC6-1D2C-4B75-93BA-5414A358B90D@perenite.com>
References: <1406418436-61452-1-git-send-email-yahoo@perenite.com>
 <6028388.mjACYPxFta@wuerfel>
 <78E68BC6-1D2C-4B75-93BA-5414A358B90D@perenite.com>
Message-ID: <9654351.pgAIO1YYYY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 July 2014 13:17:56 Benoit Masson wrote:
> 
> Ok then does this mean I can simply remove the "compatible" line to only inherits from armada-xp-dtsi ?
> 
> "i2c at 11000 {
>                                 clock-frequency = <400000>;
>                                 status = "okay";
> "
> 
> Would this be enough ?

Yes, this looks ideal.

	Arnd
