From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 25 Sep 2017 20:49:58 +0200
Subject: [PATCH 1/2] ARM: dts: exynos: Add dwc3 SUSPHY quirk
In-Reply-To: <894725fe-595b-45dc-e567-41caf48a012b@samsung.com>
References: <1505728934-6200-1-git-send-email-andrzej.p@samsung.com>
 <CGME20170918100230eucas1p29fae00c53f1106af1961a6e269740b2f@eucas1p2.samsung.com>
 <1505728934-6200-2-git-send-email-andrzej.p@samsung.com>
 <20170919174038.2sspjvadt6ggka65@kozik-lap>
 <fcefaaab-b99c-a8cc-9684-98cc3c4d803e@arm.com>
 <894725fe-595b-45dc-e567-41caf48a012b@samsung.com>
Message-ID: <20170925184958.quneytvejne2pjyb@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 22, 2017 at 10:18:54AM +0200, Andrzej Pietrasiewicz wrote:
> Hi,
> 
> W dniu 19.09.2017 o?20:10, Robin Murphy pisze:
> > On 19/09/17 18:40, Krzysztof Kozlowski wrote:
> > > On Mon, Sep 18, 2017 at 12:02:13PM +0200, Andrzej Pietrasiewicz wrote:
> > > > Odroid XU4 board does not enumerate SuperSpeed devices.
> > > > This patch makes exynos5 series chips use USB SUSPHY quirk,
> > > > which solves the problem.
> > > > 
> > > > Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>
> > > > ---
> > > >   arch/arm/boot/dts/exynos54xx.dtsi | 2 ++
> > > >   1 file changed, 2 insertions(+)
> > > 
> > > Makes sense to me... was it tested also on XU3 and XU?
> > 
> > Well, it at least doesn't make USB3 on my XU any more or less broken
> > than it was before ;) (both ports still report an over-current condition
> > even with nothing plugged in - I suspect there's probably still some
> > pinctrl/regulator stuff missing)
> > 
> > Robin.
> > 
> Similar with XU3: nothing is any more or less broken with this patch
> compared to the situation without the patch.

OK, thanks, applied!

Best regards,
Krzysztof
