From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 May 2015 19:26:18 -0300
Subject: [PATCH v1] ARM: dts: nitrogen6x: add CAN support
In-Reply-To: <1432158569-4415-1-git-send-email-ps.report@gmx.net>
References: <1432158569-4415-1-git-send-email-ps.report@gmx.net>
Message-ID: <CAOMZO5Cazk3TGSF1c4pt0WhY2stmJzHWfTyySnf_NyHxaAfgDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 6:49 PM, Peter Seiderer <ps.report@gmx.net> wrote:

> +               pinctrl_can1_1: can1grp-1 {
> +                       fsl,pins = <
> +                               MX6QDL_PAD_KEY_COL2__FLEXCAN1_TX 0x80000000
> +                               MX6QDL_PAD_KEY_ROW2__FLEXCAN1_RX 0x80000000

Better not to pass 0x80000000. Use the real PAD settings instead.
