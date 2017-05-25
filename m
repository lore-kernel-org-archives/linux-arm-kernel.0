From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 25 May 2017 11:12:08 +0200 (CEST)
Subject: [PATCH] mmc: host: fix potential null pointer dereference
In-Reply-To: <20170523234227.GA13018@embeddedgus>
References: <20170523234227.GA13018@embeddedgus>
Message-ID: <746018130.108142.1495703528403@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gustavo,

> "Gustavo A. R. Silva" <garsilva@embeddedor.com> hat am 24. Mai 2017 um 01:42 geschrieben:
> 
> 
> Null check at line 1165: if (mrq->cmd), implies that mrq->cmd might
> be NULL.
> Add null checks before dereferencing pointer mrq->cmd in order to avoid
> any potential NULL pointer dereference.
> 
> Addresses-Coverity-ID: 1408740
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

with a Raspberry Pi Zero.

But please change the subject to make sure it's bcm2835 related:

mmc: bcm2835: fix potential null pointer dereferences

Thanks
Stefan
