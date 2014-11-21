From: shijie.huang@intel.com (Huang Shijie)
Date: Fri, 21 Nov 2014 09:19:28 +0800
Subject: [PATCH v4 0/4] mtd: nand: gpmi: add proper raw access support
In-Reply-To: <20141120092336.GE3212@norris-Latitude-E6410>
References: <1413794777-32220-1-git-send-email-boris.brezillon@free-electrons.com>
 <20141120092336.GE3212@norris-Latitude-E6410>
Message-ID: <20141121011928.GB28861@shldeISGChi005.sh.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 01:23:36AM -0800, Brian Norris wrote:
> On Mon, Oct 20, 2014 at 10:46:13AM +0200, Boris Brezillon wrote:
> > This series provides an implementation for raw accesses taking care of
> > hidding the specific layout used by the GPMI controller.
> > 
> > I also updated the nand_ecc_ctrl struct documentation to clearly state that
> > specific layouts should be hidden when accessing the NAND chip in raw mode.
> 
> Can I get any ack's, tested-by's, or reviewed-by's?
> 
I will add my tested-by in the Boris's next release.

thanks
Huang Shijie
