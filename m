From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Dec 2014 12:00:38 +0100
Subject: [PATCH 2/4] irqchip: mediatek: Add support for mt8173
In-Reply-To: <1418208602-35584-3-git-send-email-eddie.huang@mediatek.com>
References: <1418208602-35584-1-git-send-email-eddie.huang@mediatek.com>
 <1418208602-35584-3-git-send-email-eddie.huang@mediatek.com>
Message-ID: <2545975.QDuBFbG7BN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 December 2014 18:50:00 Eddie Huang wrote:
> From: Yingjoe Chen <yingjoe.chen@mediatek.com>
> 
> MT8173 intpol have 32 more irq pins, add support to it.
> 
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> 

How about adding a property for the number of irq pins and leave the
old compatible string in place? I don't think it would be good if
we have to update this driver for each new SoC that uses this
irqchip just to change one number.

	Arnd
