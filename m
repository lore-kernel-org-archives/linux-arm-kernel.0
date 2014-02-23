From: computersforpeace@gmail.com (Brian Norris)
Date: Sat, 22 Feb 2014 18:37:07 -0800
Subject: [patch] mtd: nuc900_nand: NULL dereference in nuc900_nand_enable()
In-Reply-To: <20140217200308.GA9845@elgon.mountain>
References: <20140217200308.GA9845@elgon.mountain>
Message-ID: <20140223023707.GA16834@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 11:03:08PM +0300, Dan Carpenter wrote:
> Instead of writing to "nand->reg + REG_FMICSR" we write to "REG_FMICSR"
> which is NULL and not a valid register.
> 
> Fixes: 8bff82cbc308 ('mtd: add nand support for w90p910 (v2)')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Static checker stuff.

Pushed to l2-mtd.git. Thanks!

Brian
