From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 10 Jan 2016 19:23:40 +0100
Subject: [PATCH] dt-bindings: Fix the external clock name for the RK3036
 EMAC
In-Reply-To: <B588B7A8-EC8A-44A5-AEDF-F75AB5361F01@rock-chips.com>
References: <1452410557-29208-1-git-send-email-zhengxing@rock-chips.com>
 <E6BB80D3-5A62-4BE1-BFC2-74DAC9213C95@rock-chips.com>
 <B588B7A8-EC8A-44A5-AEDF-F75AB5361F01@rock-chips.com>
Message-ID: <1714176.Nme8cQ9zc4@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 10. Januar 2016, 18:36:12 schrieb Xing Zheng:
> Hi Heiko,
> 
> > ? 2016?1?10??18:29?Xing Zheng <zhengxing@rock-chips.com> ???
> > 
> > 
> > Hi Heiko,
> > 
> >> ? 2016?1?10??17:59?Heiko Stuebner <heiko@sntech.de> ???
> >> 
> >> Hi Xing,
> >> 
> >> Am Sonntag, 10. Januar 2016, 15:22:37 schrieb Xing Zheng:
> >>> Because the RK3036 doesn't support EMAC, and only support the RMII
> >>> mode
> >>> in the EMAC IP, we refer to the TRM CRU and update the new external
> >>> clock name for EMAC.
> >>> 
> >>> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> >> 
> >> as I said in the other mail, I already fixed the original patch myself
> >> :-) So I'm just going to drop this one.
> >> 
> >> 
> >> Heiko
> >> 
> >> https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/c
> >> ommit/?h=v4.5-clk/fixes&id=88807906af108a8384d77ad9cfb9421f164ea931> 
> > I am sorry to misunderstand.
> > 
> > OK, thank you for your help.  :)
> 
> Your patch is:
> - - "ext_gmac" - external GMAC clock - optional
> + - "rmii_clkin" - external GMAC clock - optional
> 
> I think that these should be like this:
> - - "ext_gmac" - external GMAC clock - optional
> + - "rmii_clkin" - external EMAC clock - optional

I fixed that up now, thanks for catching this.

https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?h=v4.5-clk/fixes&id=1c888eb1054a08620a8d2bc5dd2d7cc290897371


Heiko
