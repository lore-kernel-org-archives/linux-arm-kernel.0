From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 12 Dec 2015 00:42:05 +0100
Subject: [PATCH v2 3/4] ARM: dts: rockchip: add core rk3228 dtsi
In-Reply-To: <1537775.lkITlqtJgh@diego>
References: <1449797452-19389-1-git-send-email-jeffy.chen@rock-chips.com>
 <1449797452-19389-4-git-send-email-jeffy.chen@rock-chips.com>
 <1537775.lkITlqtJgh@diego>
Message-ID: <12513641.smzfGNJzGr@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 11. Dezember 2015, 12:25:32 schrieb Heiko St?bner:
> Hi Jeffy,
> 
> Am Freitag, 11. Dezember 2015, 09:30:51 schrieb Jeffy Chen:
> > Initial release for rk3228 shared dtsi.
> > 
> > Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> Booth dts look good now, just need to wait on Linus Walleij picking up the
> pinctrl patch first.

as the pinctrl change got picked up, I've now also applied the two dts 
patches. I've added the missing entry for 
Documentation/devicetree/bindings/arm/rockchip.txt myself now, please keep 
that in mind for future boards :-) .


Thanks
Heiko
