From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 07 Aug 2018 08:37:23 +0200
Subject: [PATCH v2 7/9] dmaengine: pxa_dma: use
 dmaenginem_async_device_register to simplify the code
In-Reply-To: <20180806085231.4597-8-sjhuang@iluvatar.ai> (Huang Shijie's
 message of "Mon, 6 Aug 2018 16:52:29 +0800")
References: <20180806085231.4597-1-sjhuang@iluvatar.ai>
 <20180806085231.4597-8-sjhuang@iluvatar.ai>
Message-ID: <87600m1y3g.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Huang Shijie <sjhuang@iluvatar.ai> writes:

> Use dmaenginem_async_device_register to simplify the code:
> 	remove dma_async_device_unregister.
>
> Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

-- 
Robert
