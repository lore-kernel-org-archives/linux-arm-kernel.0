From: rui.zhang@intel.com (Zhang Rui)
Date: Fri, 11 Aug 2017 16:01:28 +0800
Subject: [PATCH v2 0/5] thermal: rockchip: add tsadc support in thermal
 driver and IPA thermal control for rk3328 in dts
In-Reply-To: <3025917.NAhhjSz36M@phil>
References: <1501833976-1100-1-git-send-email-rocky.hao@rock-chips.com>
 <1502427095.2598.21.camel@intel.com> <3025917.NAhhjSz36M@phil>
Message-ID: <1502438488.2597.0.camel@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-08-11 at 08:27 +0200, Heiko Stuebner wrote:
> Hi,
> 
> Am Freitag, 11. August 2017, 12:51:35 CEST schrieb Zhang Rui:
> > 
> > On Fri, 2017-08-04 at 16:06 +0800, Rocky Hao wrote:
> > > 
> > > This series patches add the tsadc support in thermal driver and
> > > in
> > > devicetree for rk3328.
> > > Also add thermal control with Intelligent Power Allocation (IPA)
> > > policy by default.??Please
> > > refer to https://developer.arm.com/open-source/intelligent-power-
> > > allo
> > > cation for more information
> > > about IPA.
> > > 
> > > Rocky Hao (5):
> > > ? dt-bindings: rockchip-thermal: Support the RK3328 SoC
> > > compatible
> > > ? thermal: rockchip: Support the RK3328 SOC in thermal driver
> > > ? arm64: dts: rockchip: add tsadc node for rk3328 SoC
> > > ? arm64: dts: rockchip: add thermal nodes for rk3328 SoC
> > > ? arm64: dts: rockchip: Enable tsadc module on RK3328 eavluation
> > > board
> > > 
> > I can take this patch set if we have ACK for patch 3, 4 and 5.
> I would prefer if you would just apply patches 1+2 alone and I'd take
> the devicetree patches through my tree.
> 
> Having devicetree stuff mingle in a lot of trees produces unnecessary
> conflicts, so the general best practice is having code + binding.txt
> going through the driver tree and devicetree stuff through the
> platform
> tree.
> 
OKay, I will take patch 1 and 2 and queue them for next merge window.

thanks,
rui
> 
> Thanks
> Heiko
> 
