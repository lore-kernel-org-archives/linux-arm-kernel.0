From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Mar 2013 21:47:44 -0600
Subject: [PATCH 1/2] ARM: bcm2835: add SPI device to DT
In-Reply-To: <1362538221-19296-1-git-send-email-swarren@wwwdotorg.org>
References: <1362538221-19296-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <513EA560.1080507@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/05/2013 07:50 PM, Stephen Warren wrote:
> The BCM2835 has a single instance of the "SPI0"-type SPI master
> controller. Instantiate it in the SoC .dtsi file, Don't enable it in
> the Raspberry Pi board .dts file, since we have no idea what is actually
> connected, and hence no idea what to set the bus clock rate to.

I have applied this to bcm2835's for-3.10/dt branch.
