From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 20 Nov 2018 09:52:29 +0100
Subject: [RFC PATCH v2 11/14] dt-bindings: clock: Add Allwinner suniv
 F1C100s CCU
In-Reply-To: <5f0322d5e37726f0c597b919f59e121f0b2855c3.1542546735.git.mesihkilinc@gmail.com>
References: <cover.1542546735.git.mesihkilinc@gmail.com>
 <5f0322d5e37726f0c597b919f59e121f0b2855c3.1542546735.git.mesihkilinc@gmail.com>
Message-ID: <20181120085229.suf3affnix3d7bi2@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 18, 2018 at 05:17:10PM +0300, Mesih Kilinc wrote:
> Add compatiple string for Allwinner suniv F1C100s CCU.
> Add clock and reset definitions.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> ---
>  .../devicetree/bindings/clock/sunxi-ccu.txt        |  1 +
>  include/dt-bindings/clock/suniv-ccu-f1c100s.h      | 69 ++++++++++++++++++++++
>  include/dt-bindings/reset/suniv-ccu-f1c100s.h      | 37 ++++++++++++
>  3 files changed, 107 insertions(+)
>  create mode 100644 include/dt-bindings/clock/suniv-ccu-f1c100s.h
>  create mode 100644 include/dt-bindings/reset/suniv-ccu-f1c100s.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> index 47d2e90..92c16eb 100644
> --- a/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> +++ b/Documentation/devicetree/bindings/clock/sunxi-ccu.txt
> @@ -3,6 +3,7 @@ Allwinner Clock Control Unit Binding
>  
>  Required properties :
>  - compatible: must contain one of the following compatibles:
> +		- "allwinner,suniv-f1c100s-ccu"

Letters come after the numbers in alphabetical order, so that should
be moved at the end of that list (and you have that issue in a couple
of other patches).

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181120/76b489e1/attachment.sig>
