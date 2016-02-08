From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 8 Feb 2016 18:44:19 +0530
Subject: [PATCH v7 0/9] Fix broken DMAFLUSHP on Rockchips platform
In-Reply-To: <3817335.PXCk0JfYDT@phil>
References: <1453460812-8498-1-git-send-email-wxt@rock-chips.com>
 <56AF01B6.6030204@gmail.com> <20160208031134.GI2531@localhost>
 <3817335.PXCk0JfYDT@phil>
Message-ID: <20160208131419.GA19598@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On Mon, Feb 08, 2016 at 10:27:04AM +0100, Heiko Stuebner wrote:
> Hi Vinod,
> 
> Am Montag, 8. Februar 2016, 08:41:34 schrieb Vinod Koul:
> > On Mon, Feb 01, 2016 at 02:56:54PM +0800, Caesar Wang wrote:
> > > Hello Vinod,
> > > 
> > > Is there any chance apply the DMA patches?:-)
> > 
> > I was waiting for any ACKs on ARM patches before I merge this series.
> 
> I think the more regular way is for the driver maintainer to take the 
> driver-specific stuff and the devicetree parts going through the specific arm-
> tree. But if you really want to take the whole series, for patches 4,5,6

Yes but that causes cross tree dependencies, which looking at this won't be
a big problem, so I can safely merge dmaengine changes and rest can go thru
ARM tree.

Typically submitter should say which tree he/she prefers, which was not
provided..

So, are all okay to merge the entire series thru dmaengine tree or
independent. I don't mind either

> - ARM: dts: Add arm, pl330-broken-no-flushp quirk for rk3288 platform
> - ARM: dts: Add arm, pl330-broken-no-flushp quirk for rk3xxx platform
> - ARM: dts: add pl330-broken-no-flushp quirk for rk3036 SoCs
> 
> Acked-by: Heiko Stuebner <heiko@sntech.de>

Thanks
-- 
~Vinod
