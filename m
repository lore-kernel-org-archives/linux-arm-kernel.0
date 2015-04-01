From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 1 Apr 2015 08:39:12 -0300
Subject: [PATCH] ARM: dts: imx6: Add Embest MarS Board
In-Reply-To: <1427875809-10444-1-git-send-email-vianney.leclement@essensium.com>
References: <1427875809-10444-1-git-send-email-vianney.leclement@essensium.com>
Message-ID: <CAOMZO5DM66sUX-YojCyY5BC3Pdk4p4bkEqQ+W3tyDeNEL6nU5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 1, 2015 at 5:10 AM, Vianney le Cl?ment de Saint-Marcq
<vianney.leclement@essensium.com> wrote:
> Add device tree for the Embest/Element 14 MarS Board [1], an i.MX6 Dual
> based development board.
>
> The e-MMC chip is disabled because initialization fails (error -110).
> A possible cause is described in [2].
>
> [1] http://www.embest-tech.com/shop/star/marsboard.html
> [2] https://community.freescale.com/message/442168#442168
>
> Signed-off-by: Vianney le Cl?ment de Saint-Marcq <vianney.leclement@essensium.com>

Couldn't this be combined with the existing
arch/arm/boot/dts/imx6dl-riotboard.dts?

Regards,

Fabio Estevam
