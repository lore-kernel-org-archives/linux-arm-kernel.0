From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 23 Jan 2017 18:00:02 +0100
Subject: [PATCH v2 4/9] ARM: dts: imx28-duckbill: enable spi, i2c and uart
 pins
In-Reply-To: <1485123764-14754-5-git-send-email-mhei@heimpold.de>
References: <1485123764-14754-1-git-send-email-mhei@heimpold.de>
 <1485123764-14754-5-git-send-email-mhei@heimpold.de>
Message-ID: <96eabd96-64a6-7fbc-bb4b-223244358a42@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 22.01.2017 um 23:22 schrieb Michael Heimpold:
> While at tweak some more settings for the default product:
> - enable lradc
> - adjust USB dr mode
> - add default triggers for LEDs
> - get rid of regulators simple-bus container
> - adjust phy reset duration

since the subject line suggests something different as the actual
complete patch does, this needs to be changed.

@Shawn, @Fabio: Do we need a single patch for every point or is it
possible to squash some?
