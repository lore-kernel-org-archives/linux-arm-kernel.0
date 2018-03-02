From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 02 Mar 2018 08:43:08 +0100
Subject: [PATCH v3 3/5] arm64: dts: rockchip: add usb3-phy otg-port
 support for rk3399.
In-Reply-To: <9229851.uS1UDVWbBb@phil>
References: <20171215110005.7564-1-enric.balletbo@collabora.com>
 <20171215110005.7564-3-enric.balletbo@collabora.com>
 <9229851.uS1UDVWbBb@phil>
Message-ID: <1798650.vypR2cBVd9@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Samstag, 16. Dezember 2017, 18:06:50 CET schrieb Heiko Stuebner:
> Am Freitag, 15. Dezember 2017, 12:00:03 CET schrieb Enric Balletbo i Serra:
> > Add the usb3 phyter for the USB3.0 OTG controller.
> > 
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> applied for 4.16

and reverted again for the 4.16 cycle due to the regressions it causes on
non-gru boards.

I've requeued it in my temporary 4.18 branch and will readd it once
the typec-phy changeset gets merged.


Heiko
