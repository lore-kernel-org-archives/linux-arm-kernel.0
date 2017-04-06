From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 07 Apr 2017 00:23:39 +0200
Subject: [PATCH 2/3] ARM: dts: rockchip: rock2: Setup usb vbus-supply
In-Reply-To: <20170405140613.4444-3-sjoerd.simons@collabora.co.uk>
References: <20170405140613.4444-1-sjoerd.simons@collabora.co.uk>
 <20170405140613.4444-3-sjoerd.simons@collabora.co.uk>
Message-ID: <2204588.mS7ruK0rnT@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 5. April 2017, 16:06:11 CEST schrieb Sjoerd Simons:
> Now that the rockchip usb phy has a vbus-supply property use that to
> control the vbus regulator on rock2.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

I've queued this for 4.13 .

Not eligible for 4.12, as the patch alone (when testing my tree or armsoc)
would regress the sata-bridge, due to the regulator-always-on going away.


Heiko
