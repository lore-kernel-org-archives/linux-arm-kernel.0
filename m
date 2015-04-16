From: robherring2@gmail.com (Rob Herring)
Date: Thu, 16 Apr 2015 17:54:38 -0500
Subject: [trivial PATCH] arm: dts: socfpga: Remove executable permission
 bits
In-Reply-To: <1429224565.2850.62.camel@perches.com>
References: <1429224565.2850.62.camel@perches.com>
Message-ID: <CAL_Jsq+VN15c-LE_iQzx1AnoPWmNEtjVgiEBb2OkHQPP=ZrQMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+arm-soc

On Thu, Apr 16, 2015 at 5:49 PM, Joe Perches <joe@perches.com> wrote:
> Change the .dts file permissions from 755 to 644.
>
> Signed-off-by: Joe Perches <joe@perches.com>

ARM dts files go in thru arm-soc tree.

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  arch/arm/boot/dts/socfpga_arria10_socdk.dts | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dts b/arch/arm/boot/dts/socfpga_arria10_socdk.dts
> old mode 100755
> new mode 100644
>
>
