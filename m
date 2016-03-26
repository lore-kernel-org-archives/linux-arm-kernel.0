From: ipaton0@gmail.com (Iain Paton)
Date: Sat, 26 Mar 2016 00:48:44 +0000
Subject: [linux-sunxi] [PATCH 3/3] sunxi: A20-OLinuXino-LIME2: Add i2c2
 bus in DTS
In-Reply-To: <1458932647-24268-3-git-send-email-haas@computerlinguist.org>
References: <1458932647-24268-1-git-send-email-haas@computerlinguist.org>
 <1458932647-24268-3-git-send-email-haas@computerlinguist.org>
Message-ID: <56F5DC6C.4070005@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/03/16 19:04, Michael Haas wrote:
> The A20 processor provides a third I2C bus on pins PB20 and PB21.
> The A20-OLinuXino-LIME2 exposes this bus via its GPIO1 port.
> 
> Olimex also provide a breakout board called the
> A20-OLinuXino-LIME2-UEXT. This change is required to properly
> support I2C on the UEXT connector found there.
> 
> Signed-off-by: Michael Haas <haas@computerlinguist.org>

Acked-by: Iain Paton <ipaton0@gmail.com>

This didn't go in originally simply because not everyone will have 
the breakout and they may want to use those pins for other things.
