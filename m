From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 01 Sep 2016 22:43:32 +0200
Subject: [PATCH v4 0/3] nvmem: rockchip-efuse: support more rockchip SoCs
In-Reply-To: <f9c6e53e-ae5f-d67a-3464-e10a3dee808c@linaro.org>
References: <1472464210-30252-1-git-send-email-finley.xiao@rock-chips.com>
 <f9c6e53e-ae5f-d67a-3464-e10a3dee808c@linaro.org>
Message-ID: <3728837.exfccSJxkh@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi srini,

Am Donnerstag, 1. September 2016, 21:02:23 schrieb Srinivas Kandagatla:
> On 29/08/16 10:50, Finley Xiao wrote:
> > As the timing and organization of efuse may be different
> > between rockchip SoCs, so their read function may be different.
> > We add different device tree compatible string for rockchip SoCs
> > to match their own read function.
> > 
> > V3->V4:
> > - 3/3 change the type of out_value into u32 and buf into u8, their values
> > 
> >   come from register, use u32 and u8 may be more readable.
> > 
> > Finley Xiao (3):
> >   nvmem: rockchip-efuse: update compatible strings for Rockchip efuse
> >   ARM: dts: rockchip: update compatible strings for Rockchip efuse
> >   nvmem: rockchip-efuse: add rk3399-efuse support
> 
> I can take patch 1 and 3, but dts has to go via arm soc tree.

that is really fine, and also what I somehow expect :-) .

So once you picked these two (I guess after Doug's comments are fixed) I'll 
pick up the dts patch.


Heiko
