From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 6 Dec 2013 14:07:40 +0100
Subject: [PATCHv5][ 3/8] staging: imx-drm: Correct BGR666 and the board's
 dts that use them.
In-Reply-To: <1386268092-21719-3-git-send-email-denis@eukrea.com>
References: <1386268092-21719-1-git-send-email-denis@eukrea.com>
 <1386268092-21719-3-git-send-email-denis@eukrea.com>
Message-ID: <20131206130739.GD30625@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 05, 2013 at 07:28:07PM +0100, Denis Carikli wrote:
[...]
> diff --git a/arch/arm/boot/dts/imx51-apf51dev.dts b/arch/arm/boot/dts/imx51-apf51dev.dts
> index f36a3aa..3b6de6a 100644
> --- a/arch/arm/boot/dts/imx51-apf51dev.dts
> +++ b/arch/arm/boot/dts/imx51-apf51dev.dts
> @@ -19,7 +19,7 @@
>  	display at di1 {
               ^^^^

I know this isn't introduced by your patch, but WTF???

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/6a4dcda7/attachment.sig>
