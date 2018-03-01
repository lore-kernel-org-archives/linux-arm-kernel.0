From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 1 Mar 2018 12:29:05 -0300
Subject: [PATCH] ARM: dts: imx7d-sdb: Fix regulator-usb-otg2-vbus node name
In-Reply-To: <ca6bd71c64691209cae279e2c094ce511a9e7419.1519908633.git.leonard.crestez@nxp.com>
References: <ca6bd71c64691209cae279e2c094ce511a9e7419.1519908633.git.leonard.crestez@nxp.com>
Message-ID: <CAOMZO5BvyykO_R5Expwnvu3w89QZ4TgE-it3sOSXKewBTpDD_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 1, 2018 at 9:52 AM, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> The two usb-otg regulators for imx7d-sdb are both called
> "regulator-usb-otg1-vbus" and they effectively override each other.
>
> This is most likely a copy-paste error.
>
> Fixes: b877039aa1fe ("ARM: dts: imx7d-sdb: Adjust the regulator nodes")
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Good catch, thanks:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
