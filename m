From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 30 May 2017 14:04:03 +0200
Subject: [PATCH 4/6] irqchip: irq-mvebu-icu: new driver for Marvell ICU
In-Reply-To: <1496135772-20694-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1496135772-20694-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1496135772-20694-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20170530120403.GB25456@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

Very small comment,

On Tue, May 30, 2017 at 11:16:09AM +0200, Thomas Petazzoni wrote:
> diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
[...]
> +#define ICU_INT_CFG(x)          (0x100 + 4 * x)

You should use (x) here, to be safe.

Thanks!
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170530/e3e42e3c/attachment-0001.sig>
