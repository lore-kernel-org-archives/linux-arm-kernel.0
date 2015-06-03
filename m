From: marex@denx.de (Marek Vasut)
Date: Wed, 3 Jun 2015 14:41:53 +0200
Subject: [PATCH] ARM: dts: mx23: fix iio-hwmon support
In-Reply-To: <1433282608-16257-1-git-send-email-stefan.wahren@i2se.com>
References: <1433282608-16257-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <201506031441.53944.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 03, 2015 at 12:03:28 AM, Stefan Wahren wrote:
> In order to get iio-hwmon support, the lradc must be declared as an
> iio provider. So fix this issue by adding the #io-channel-cells property.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: bd798f9c7b30 ("ARM: dts: mxs: Add iio-hwmon to mx23 soc")

Reviewed-by: Marek Vasut <marex@denx.de>

[...]

Best regards,
Marek Vasut
