From: shijie.huang@intel.com (Huang Shijie)
Date: Fri, 21 Nov 2014 09:13:48 +0800
Subject: [PATCH v4 1/4] mtd: nand: provide detailed description for raw
 read/write page methods
In-Reply-To: <20141120080627.GB3212@norris-Latitude-E6410>
References: <1413794777-32220-1-git-send-email-boris.brezillon@free-electrons.com>
 <1413794777-32220-2-git-send-email-boris.brezillon@free-electrons.com>
 <20141120080627.GB3212@norris-Latitude-E6410>
Message-ID: <20141121011348.GA28861@shldeISGChi005.sh.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 12:06:27AM -0800, Brian Norris wrote:
> On Mon, Oct 20, 2014 at 10:46:14AM +0200, Boris Brezillon wrote:
> > read_page_raw and write_page_raw method description is not clear enough.
> > It clearly specifies that ECC correction should not be involved but does
> > not talk about specific layout (by layout I mean where in-band and
> > out-of-band data are stored on the NAND media) used by NAND/ECC
> > controllers.
> > 
> > Those specific layouts might impact MTD users and thus should be hidden (as
> > already done in the standard NAND_ECC_HW_SYNDROME implementation).
> > 
> > Clearly state this constraint in the nand_ecc_ctrl struct documentation.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> Pushed this patch to l2-mtd.git. Thanks!
thanks.

I am really happy you can merge this patch.

Huang Shijie
