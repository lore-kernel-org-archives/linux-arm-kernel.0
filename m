From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 4 Nov 2016 18:48:05 -0200
Subject: [PATCH] ARM: dts: imx6: Add imx-weim parameters to dtsi's
In-Reply-To: <1478044305-5666-1-git-send-email-stillcompiling@gmail.com>
References: <1478044305-5666-1-git-send-email-stillcompiling@gmail.com>
Message-ID: <CAOMZO5DtSgY2bmW74gv+1+HLRkPNc8upCfYX-JtQDyjMn6jNxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 1, 2016 at 9:51 PM, Joshua Clayton <stillcompiling@gmail.com> wrote:
> imx-weim should always set address-cells to 2,
> and size_cells to 1.
> On imx6, fsl,weim-cs-gpr will always be &gpr
>
> Set these common parameters in the dtsi file,
> rather than in a downstream dts.
>
> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
