From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 01 Sep 2015 22:58:59 +0200
Subject: [PATCH v4 10/16] phy: Add driver for rockchip Display Port PHY
In-Reply-To: <5077044.NGUl9gjQon@phil>
References: <1441086371-24838-1-git-send-email-ykk@rock-chips.com>
 <1441087455-25533-1-git-send-email-ykk@rock-chips.com>
 <5077044.NGUl9gjQon@phil>
Message-ID: <3270549.qIHk1CAA0Y@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yakir,

small nit more below

Am Dienstag, 1. September 2015, 18:51:16 schrieb Heiko Stuebner:
> Am Dienstag, 1. September 2015, 14:04:15 schrieb Yakir Yang:
> > +- clocks: from common clock binding: handle to dp clock.
> > +	of memory mapped region.
> > +- clock-names: from common clock binding:
> > +	Required elements: "sclk_dp" "sclk_dp_24m"
> > +
> > +- rockchip,grf: this soc should set GRF regs, so need get grf here.
> > +- #phy-cells : from the generic PHY bindings, must be 0;
> > +
> > +Example:
> > +
> > +edp_phy: phy at ff770274 {
> 
> edp_phy: edp-phy {
> 
> > +	compatilble = "rockchip,rk3288-dp-phy";

typo: compatible
