From: iwamatsu@nigauri.org (Nobuhiro Iwamatsu)
Date: Wed, 16 Jan 2013 09:01:01 +0900
Subject: [PATCH 5/6] arm: mvebu: Enable USB controllers on Armada XP
 OpenBlocks AX3-4 board
In-Reply-To: <1358243670-11935-5-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1358243670-11935-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1358243670-11935-5-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <CABMQnVLD+VKj53dfQC24AwCboed3EGt+gqTKt-B9q8nhEx3Ytg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,



On Tue, Jan 15, 2013 at 6:54 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> Cc: Lior Amsalem <alior@marvell.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
> index b24644f..55f5b6f 100644
> --- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
> +++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
> @@ -127,5 +127,14 @@
>                         nr-ports = <2>;
>                         status = "okay";
>                 };
> +               usb at d0050000 {
> +                       status = "okay";
> +               };
> +               usb at d0051000 {
> +                       status = "okay";
> +               };
> +               usb at d0052000 {
> +                       status = "okay";
> +               };
USB2 of openblocks-ax3-4 is used as Mini-PCIE.
I think this is unnecessary.

>         };
>  };
> --
> 1.7.8.6
>

Best regards,
  Nobuhiro

-- 
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org}
   GPG ID: 40AD1FA6
