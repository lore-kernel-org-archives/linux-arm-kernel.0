From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 17 Feb 2016 07:45:09 +0100
Subject: [PATCH] spi/rockchip: Add dt-binding for Rockchip rk3399 spi
In-Reply-To: <56C3BD26.3030704@rock-chips.com>
References: <1455614538-4415-1-git-send-email-jay.xu@rock-chips.com>
 <1730751.NYv1NxJVuB@phil> <56C3BD26.3030704@rock-chips.com>
Message-ID: <4579617.rz6Yi2sU5M@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jianqun,

Am Mittwoch, 17. Februar 2016, 08:21:58 schrieb Jianqun Xu:
> ? 16/02/2016 22:37, Heiko Stuebner ??:
> > Am Dienstag, 16. Februar 2016, 13:22:23 schrieb Mark Brown:
> >> On Tue, Feb 16, 2016 at 05:22:18PM +0800, jianqun.xu wrote:
> >>>   Documentation/devicetree/bindings/spi/spi-rockchip.txt | 1 +
> >>>   1 file changed, 1 insertion(+)
> >> 
> >> I'd expect this to be added to both the driver and the binding document
> >> not just the document.
> > 
> > It seems the driver can still use the rk3066-variant - aka nobody has
> > found specific issues in the rk3399 IP implementation.
> > 
> > Having the more specific IP names already in the dts before actually
> > using them was suggested by devicetree people to not have to exchange
> > everything once specific issues were found.
> > 
> > So right now it's using the fallback-mechanism of binding to the rk3066
> > name, but if some obstacle appears it will only take adding the binding
> > in the driver to make it work (even with old devicetrees).
> 
> Thank you, got it, and I will re-send this patch with the driver patch.

you have me confused now :-) .

That was meant as a reply to Mark's comment, explaining why the double 
compatible and the driver only binding to the rk3066-one right now.


Heiko
