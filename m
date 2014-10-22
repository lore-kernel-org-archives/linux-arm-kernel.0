From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 22 Oct 2014 10:38:02 +0200
Subject: [PATCH v2 4/4] ARM: dts: sun7i: Add lradc node
In-Reply-To: <1413879890-7254-5-git-send-email-hdegoede@redhat.com>
References: <1413879890-7254-1-git-send-email-hdegoede@redhat.com>
 <1413879890-7254-5-git-send-email-hdegoede@redhat.com>
Message-ID: <20141022083802.GE7893@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Tue, Oct 21, 2014 at 10:24:50AM +0200, Hans de Goede wrote:
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 48 +++++++++++++++++++++++++
>  arch/arm/boot/dts/sun7i-a20.dtsi                |  7 ++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> index 9d669cdf..85e7194 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
> @@ -14,6 +14,7 @@
>  /dts-v1/;
>  /include/ "sun7i-a20.dtsi"
>  /include/ "sunxi-common-regulators.dtsi"
> +#include <dt-bindings/input/input.h>

I'm just wondering... Weren't we supposed to switch all includes to
the preprocessor syntax in such a case?

Maybe to handle the case were the DTSIs would have to use some
preprocessors macros that wouldn't be expanded in this case?

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141022/de46738a/attachment.sig>
