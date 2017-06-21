From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 22 Jun 2017 00:06:37 +0800
Subject: [PATCH 2/2] i2c: zx2967: add i2c controller driver for ZTE's
 zx2967 family
In-Reply-To: <20170620074126.GA1541@katana>
References: <1495947576-11037-1-git-send-email-shawnguo@kernel.org>
 <1495947576-11037-3-git-send-email-shawnguo@kernel.org>
 <20170619193130.velebm7p3r5ggaos@ninjato>
 <20170620025815.GA4818@x250> <20170620074126.GA1541@katana>
Message-ID: <20170621160635.GF3372@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 09:41:26AM +0200, Wolfram Sang wrote:
> Nice. Can you also run 'i2cdetect' on the bus to see if we have proper
> NAK handling? AFAICS this should be broken now. And very slow with
> previous versions of the driver.

Sure, thanks for the suggestion.  I will make sure that 'i2cdetect' is
happy with the driver.

Shawn
