From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 14 Sep 2016 17:27:27 +0200
Subject: [GIT PULL 4/4] arm64: tegra: Device tree changes for v4.9-rc1
In-Reply-To: <20160909152032.9550-4-thierry.reding@gmail.com>
References: <20160909152032.9550-1-thierry.reding@gmail.com>
 <20160909152032.9550-4-thierry.reding@gmail.com>
Message-ID: <2773980.1MuS3EVqLd@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 9, 2016 5:20:32 PM CEST Thierry Reding wrote:
> arm64: tegra: Device tree changes for v4.9-rc1
> 
> Add a couple of devices (AGIC, ADMA) on Tegra210 and enable them on
> Smaug. Also enable DPAUX on Smaug to allow the I2C bus that shares pads
> with the DPAUX to be used to access various audio devices. Furthermore,
> enable the XUSB controller on Smaug for USB 3.0 support.
> 
> Finally, select PM_GENERIC_DOMAINS for 64-bit Tegra devices to make sure
> devices are probed only after their power partitions have been enabled.
> 

Pulled into next/dt64, thanks!

	Arnd
