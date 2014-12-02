From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Dec 2014 10:38:37 +0100
Subject: [PATCH] ARM: BCM5301X: Add IRQs to Broadcom's bus-axi in DTS file
In-Reply-To: <1417470667-15679-1-git-send-email-hauke@hauke-m.de>
References: <1417470667-15679-1-git-send-email-hauke@hauke-m.de>
Message-ID: <2676777.ByaIh4AdF3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 01 December 2014 22:51:07 Hauke Mehrtens wrote:
> IRQ support for Broadcom's bus-axi driver bcma was merged into John
> Linville's wireless tree and will show up in 3.19. This patch makes use
> of this feature in the DTS file for the the BCM5301X SoCs. I left the
> PCIe controller out, because this still needs some discussion.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Looks good to me.

Acked-by: Arnd Bergmann <arnd@arndb.de>

I assume you are going to send this together with some other patches
you have queued up?
