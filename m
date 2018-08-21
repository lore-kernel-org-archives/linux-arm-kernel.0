From: marcel@holtmann.org (Marcel Holtmann)
Date: Tue, 21 Aug 2018 16:57:11 +0200
Subject: [PATCH] Bluetooth: mediatek: Fix memory leak
In-Reply-To: <20180814151031.GA25096@embeddedor.com>
References: <20180814151031.GA25096@embeddedor.com>
Message-ID: <E5153D2C-A52F-4BA8-8B79-A19338BDC12D@holtmann.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gustavo,

> In case memory resources for *fw* were allocated, release them before
> return.
> 
> Addresses-Coverity-ID: 1472611 ("Resource leak")
> Fixes: 7237c4c9ec92 ("Bluetooth: mediatek: Add protocol support for MediaTek serial devices")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> drivers/bluetooth/btmtkuart.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel
