From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 21 Mar 2018 06:14:55 -0500
Subject: [PATCH] iommu/mediatek: Fix protect memory setting
In-Reply-To: <1521609504.24119.5.camel@mhfsdcap03>
References: <1521337974-22112-1-git-send-email-yong.wu@mediatek.com>
 <20180320185716.ldxs2vvfcchznpnb@8bytes.org>
 <1521609504.24119.5.camel@mhfsdcap03>
Message-ID: <20180321111455.djllpdsj35vu5cxc@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2018 at 01:18:24PM +0800, Yong Wu wrote:
> On Tue, 2018-03-20 at 13:57 -0500, Joerg Roedel wrote:
> > On Sun, Mar 18, 2018 at 09:52:54AM +0800, Yong Wu wrote:
> > > To avoid adding this complex macro or a new function, I put
> > > it in the code and backup its value in the suspend registers.
> > 
> > Missing Signed-off-by.
> 
> Signed-off-by and Reported-by have been added above.
> 
> ====
> Reported-by: Honghui Zhang <honghui.zhang@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ====

Right, sorry. I was in a hurry and missed it. Patch is now applied.


Thanks,

	Joerg
