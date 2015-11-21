From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 21 Nov 2015 17:41:47 +0100
Subject: [PATCH v4 00/10] Better compatible for the rockchip thermal and
 support RK3368 SoCs
In-Reply-To: <20151112183119.GA5289@localhost.localdomain>
References: <1447044542-30859-1-git-send-email-wxt@rock-chips.com>
 <20151112182950.GB4361@localhost.localdomain>
 <20151112183119.GA5289@localhost.localdomain>
Message-ID: <1718129.opDY4sItVM@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 12. November 2015, 10:31:20 schrieb Eduardo Valentin:
> On Thu, Nov 12, 2015 at 10:29:52AM -0800, Eduardo Valentin wrote:
> > On Mon, Nov 09, 2015 at 12:48:52PM +0800, Caesar Wang wrote:
> > > Thank you all for providing inputs and comments on previous versions of
> > > this patchset.
> > > Especially thanks to the (Eduardo, Dmitry, Heiko,....).
> > > 
> > > This series patchs are working for RK3368 on Rockchip platform.
> > 
> > Do you have any results on existing support? Is the driver still in one
> > piece for rk3288?
> > 
> > I am planing to send your series in next rc cycles. It won't appear in
> > linux-next until merge window finishes.
> 
> To be more specific, only patches 1-7. DT bindings go via the right
> machine tree.

after seeing these 7 patches in your next-branch, I've now applied the 3
dts patches to my dts64 branch for 4.5 as well.


Thanks
Heiko
