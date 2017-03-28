From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 28 Mar 2017 22:22:31 +0200
Subject: [PATCH] ARM: dts: rockchip: Enable sata support on rock2 square
In-Reply-To: <20170317135118.17333-1-sjoerd.simons@collabora.co.uk>
References: <20170317135118.17333-1-sjoerd.simons@collabora.co.uk>
Message-ID: <3611879.WML2keYtTn@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 17. M?rz 2017, 14:51:17 CEST schrieb Sjoerd Simons:
> The Rock 2 square board has a USB -> SATA converter hooked up to its usb
> host1 connection. Enable the usb controller and always turn on the power
> on the 5V sata power connector (controlled by gpio).
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

applied for 4.12

Thanks
Heiko
