From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 13 Jul 2018 15:00:40 -0300
Subject: [PATCH 2/3] ARM: dts: imx6sll-evk: correct lcd regulator GPIO pin
In-Reply-To: <1531468707-25737-2-git-send-email-Anson.Huang@nxp.com>
References: <1531468707-25737-1-git-send-email-Anson.Huang@nxp.com>
 <1531468707-25737-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5DFrBr=gC_qwFC4yHxT-KH5NMh56a8cL6F=T72XmzRMnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 4:58 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> On i.MX6SLL EVK board, lcd regulator is controlled
> by GPIO4 IO03 using MX6SLL_PAD_KEY_ROW5__GPIO4_IO03 pin,
> NOT MX6SLL_PAD_ECSPI1_SCLK__GPIO4_IO08, correct it.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
