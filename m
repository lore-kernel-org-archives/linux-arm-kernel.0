From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 30 Mar 2016 21:17:49 +0200
Subject: [PATCH v5 21/50] mtd: nand: jz4740: switch to mtd_ooblayout_ops
In-Reply-To: <1459354505-32551-22-git-send-email-boris.brezillon@free-electrons.com>
References: <1459354505-32551-1-git-send-email-boris.brezillon@free-electrons.com>
 <1459354505-32551-22-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <56FC265D.8070500@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/30/2016 06:14 PM, Boris Brezillon wrote:
> Implementing the mtd_ooblayout_ops interface is the new way of exposing
> ECC/OOB layout to MTD users.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
