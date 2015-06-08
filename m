From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 8 Jun 2015 20:04:04 +0200
Subject: [PATCH] ARM: dts: mx23: fix iio-hwmon support
In-Reply-To: <1433282608-16257-1-git-send-email-stefan.wahren@i2se.com>
References: <1433282608-16257-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20150608180404.GD5222@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2015 at 22:03:28 +0000, Stefan Wahren wrote :
> In order to get iio-hwmon support, the lradc must be declared as an
> iio provider. So fix this issue by adding the #io-channel-cells property.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: bd798f9c7b30 ("ARM: dts: mxs: Add iio-hwmon to mx23 soc")

Reviewed-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
