From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 13 Nov 2016 09:50:47 -0200
Subject: [PATCH] ARM: dts: imx6sx-udoo: Add board specific compatible
 strings
In-Reply-To: <1478021892-18344-1-git-send-email-fabio.estevam@nxp.com>
References: <1478021892-18344-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <CAOMZO5BD5oULHOKQ7Uii9FMxiSYNY_WiKC1XtxLaN=36jTeH0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Tue, Nov 1, 2016 at 3:38 PM, Fabio Estevam <fabio.estevam@nxp.com> wrote:
> Add a compatible entry for the specific board versions.
>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts    | 2 +-
>  arch/arm/boot/dts/imx6sx-udoo-neo-extended.dts | 2 +-
>  arch/arm/boot/dts/imx6sx-udoo-neo-full.dts     | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts b/arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts
> index 0b88878..0c1fc1a 100644
> --- a/arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts
> +++ b/arch/arm/boot/dts/imx6sx-udoo-neo-basic.dts
> @@ -46,7 +46,7 @@
>
>  / {
>         model = "UDOO Neo Basic";
> -       compatible = "fsl,imx6sx";
> +       compatible = "udoo,neobasic", "fsl,imx6sx";

Just to let you know that Rob has alreasy applied the patch that add
udoo in vendor-prefixes.txt:
https://git.kernel.org/cgit/linux/kernel/git/robh/linux.git/commit/?h=for-next&id=61bdc6a118e402543a724808c651bb7ca2751bd9
