From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Jun 2015 19:58:21 +0800
Subject: [PATCH] ARM: dts: mx23: fix iio-hwmon support
In-Reply-To: <1433282608-16257-1-git-send-email-stefan.wahren@i2se.com>
References: <1433282608-16257-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <20150629115821.GM10332@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 10:03:28PM +0000, Stefan Wahren wrote:
> In order to get iio-hwmon support, the lradc must be declared as an
> iio provider. So fix this issue by adding the #io-channel-cells property.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Fixes: bd798f9c7b30 ("ARM: dts: mxs: Add iio-hwmon to mx23 soc")

Applied with a stable tag, thanks.
