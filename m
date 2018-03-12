From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Mar 2018 15:35:37 +0100
Subject: [GIT PULL 2/2] Rockchip dts64 fixes for 4.16
In-Reply-To: <304170820.2ZTNuuGKzZ@phil>
References: <22043255.iBjVuxpHK5@phil> <304170820.2ZTNuuGKzZ@phil>
Message-ID: <CAK8P3a3ik5fjZM6qpXNFVgkJbgT_vAetbHLt+k=Zs1o++B_BAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2018 at 9:38 AM, Heiko Stuebner <heiko@sntech.de> wrote:
> ----------------------------------------------------------------
> Pinctrl got a fix in 4.16-rc1, that exposed an issue with wifi-related
> pinctrl hogs on rk3399-gru-kevin that broke suspend. This gets fixed
> by moving the wifi pinctrl to the correct node.
> Also revert the usb3 phy-port enablement, as a missing feature in the
> type-c phy breaks usb on all non-gru rk3399 boards.

Pulled into fixes, thanks!

     Arnd
