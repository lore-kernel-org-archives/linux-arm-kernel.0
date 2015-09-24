From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 25 Sep 2015 00:13:29 +0200
Subject: [PATCH v2 0/5] ARM: multi_v7_defconfig: Improve rockchip support
In-Reply-To: <1443094759-28531-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1443094759-28531-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <3696254.URXbzz0NG2@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 24. September 2015, 13:39:14 schrieb Sjoerd Simons:
> Enable options to provide more complete support for Rockchip boards
> including: support for the common PMICs, common RTC chips, I2C, SPI,
> PMW, Thermal driver, HDMI video output and USB 2.

As these patches are supposed to go through arm-soc directly and options 
getting enabled + the whole what gets set as built-in vs. module looks sane to 
me, I'll just provide for the whole series a:

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


Heiko
