From: davem@davemloft.net (David Miller)
Date: Wed, 03 Apr 2013 12:33:03 -0400 (EDT)
Subject: [PATCH v4 0/6] Generic PHY Framework
In-Reply-To: <515BCDB2.2040506@ti.com>
References: <515BC559.1070602@ti.com>
 <20130403.023157.1254170239558661397.davem@davemloft.net>
 <515BCDB2.2040506@ti.com>
Message-ID: <20130403.123303.544482473271388131.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Wed, 3 Apr 2013 12:05:30 +0530

> This patch series is about drivers/phy which will be used for now by
> usb, sata and maybe some video PHY's. Network itself has a
> comprehensive PHY in drivers/net/phy which we'd like to merge it with
> drivers/phy so that we have all the phy stuff in drivers/phy but we
> are not planning too far ahead here.

Ok, that makes sense, thanks.
