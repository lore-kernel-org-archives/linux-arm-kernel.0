From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Oct 2015 16:14:14 +0200
Subject: [PATCH v2 0/5] ARM: multi_v7_defconfig: Improve rockchip support
In-Reply-To: <3696254.URXbzz0NG2@diego>
References: <1443094759-28531-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <3696254.URXbzz0NG2@diego>
Message-ID: <5148310.s4EONgC5KW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 September 2015 00:13:29 Heiko St?bner wrote:
> Am Donnerstag, 24. September 2015, 13:39:14 schrieb Sjoerd Simons:
> > Enable options to provide more complete support for Rockchip boards
> > including: support for the common PMICs, common RTC chips, I2C, SPI,
> > PMW, Thermal driver, HDMI video output and USB 2.
> 
> As these patches are supposed to go through arm-soc directly and options 
> getting enabled + the whole what gets set as built-in vs. module looks sane to 
> me, I'll just provide for the whole series a:
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Applied them all to next/defconfig

Thanks,

	Arnd
