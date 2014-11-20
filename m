From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 20 Nov 2014 00:06:27 -0800
Subject: [PATCH v4 1/4] mtd: nand: provide detailed description for raw
 read/write page methods
In-Reply-To: <1413794777-32220-2-git-send-email-boris.brezillon@free-electrons.com>
References: <1413794777-32220-1-git-send-email-boris.brezillon@free-electrons.com>
 <1413794777-32220-2-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20141120080627.GB3212@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 10:46:14AM +0200, Boris Brezillon wrote:
> read_page_raw and write_page_raw method description is not clear enough.
> It clearly specifies that ECC correction should not be involved but does
> not talk about specific layout (by layout I mean where in-band and
> out-of-band data are stored on the NAND media) used by NAND/ECC
> controllers.
> 
> Those specific layouts might impact MTD users and thus should be hidden (as
> already done in the standard NAND_ECC_HW_SYNDROME implementation).
> 
> Clearly state this constraint in the nand_ecc_ctrl struct documentation.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Pushed this patch to l2-mtd.git. Thanks!

Brian
