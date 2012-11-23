From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 23 Nov 2012 23:06:44 +0900
Subject: [PATCH 1/1] ASoC: Ux500: Initialise PCM from MSP probe rather
 than as a device
In-Reply-To: <1353675941-7303-1-git-send-email-lee.jones@linaro.org>
References: <1353675941-7303-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20121123140643.GO4529@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 01:05:41PM +0000, Lee Jones wrote:
> The PCM is a pseudo-device. It doesn't have any of it's own registers
> or hardware. It rather acts as a layer of abstraction for DMA
> transfers. Hence, instead of classifying it as a device in its own
> right, we call the initialisation from the MSP driver.

Applied, thanks.  Please always submit patches against the latest
development versions of code.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121123/2cb89e80/attachment.sig>
