From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 14 May 2015 20:44:49 +0200
Subject: [PATCH 0/8] ARM: dts: rockchip: the big relicensing
In-Reply-To: <1425665046-22927-1-git-send-email-heiko@sntech.de>
References: <1425665046-22927-1-git-send-email-heiko@sntech.de>
Message-ID: <1881847.GTHrUCPx3W@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eddie and Rockchip people,

Am Freitag, 6. M?rz 2015, 19:03:58 schrieb Heiko Stuebner:
> GPL2/X11 seems to be the consensus to go for devicetree files, as shown for
> examply by armada, meson and sunxi.

just to explain a bit more, this is helpful if other operating systems like 
the BSDs want to share the devicetree files which are in any case supposed to 
be operating-system-agnostic.


It looks like I got all needed external ACKs but am missing ACKs from some 
Rockchip engineers who contributed to these files.

Ideally the listed people could respond individually to the patches in their 
mailboxes (from beginning of march) with an Acked-by tag.

But as all of them are employed by Rockchip it should also be possible for 
Eddie to Ack the change summarily on behalf of Rockchip if this is acceptable.


>   ARM: dts: rockchip: relicense rk3288.dtsi under GPLv2/X11
 Addy Ke <addy.ke@rock-chips.com>
 Andy Yan <andy.yan@rock-chips.com>
 Chris Zhong <zyw@rock-chips.com>
 Jianqun Xu<jay.xu@rock-chips.com>
 Roger Chen <roger.chen@rock-chips.com>
 Yunzhi Li <lyz@rock-chips.com>
 huang lin <hl@rock-chips.com>

>   ARM: dts: rockchip: relicense rk3288-evb* under GPLv2/X11
 Chris Zhong <zyw@rock-chips.com>
 Roger Chen <roger.chen@rock-chips.com>
 Yunzhi Li <lyz@rock-chips.com>


Thanks
Heiko
