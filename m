From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 18 Dec 2013 17:43:14 +0530
Subject: [PATCH v3] ARM: davinci: aemif: get rid of davinci-nand driver
 dependency on aemif
In-Reply-To: <52B18C44.2000305@ti.com>
References: <1386267092-18615-1-git-send-email-ivan.khoronzhuk@ti.com>
 <52B18C44.2000305@ti.com>
Message-ID: <52B1915A.7060309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 December 2013 05:21 PM, ivan.khoronzhuk wrote:
> Hi, Sekhar
> 
> This patch is based on "Reuse davinci-nand driver for Keystone arch" series.
> The series has passed review at https://lkml.org/lkml/2013/12/17/241
> and can be found at http://git.infradead.org/l2-mtd.git
> 
> This patch can be still applied on top of the series without conflicts. 
> 
> Can you please pick up the $subject patch if you are OK with it?

I have no problems with the patch and can pick it too, but need ack from
MTD maintainer (David) as it touches drivers/mtd/ too.

David,

If you do not have the patch, we can resend it.

Thanks,
Sekhar
