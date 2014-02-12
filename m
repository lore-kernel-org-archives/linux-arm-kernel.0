From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Feb 2014 22:05:06 -0700
Subject: [PATCH 1/2] BCM2835: Add dmaengine driver to device tree
In-Reply-To: <52D3C9EF.1030901@koalo.de>
References: <52D3C9EF.1030901@koalo.de>
Message-ID: <52FB0102.3080108@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2014 04:11 AM, Florian Meier wrote:
> This adds the definitions for the BCM2835 dmaengine driver
> to the device tree. The dma-channel-mask is currently
> fixed. Later it should be set via the firmware.

I've applied patch 1, and the part of patch 2 which touches bcm2835.dtsi
to bcm2835's for-3.15/dt branch, with minor fixes.
