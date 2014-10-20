From: koen@dominion.thruhere.net (Koen Kooi)
Date: Mon, 20 Oct 2014 14:02:59 +0200
Subject: [linux-sunxi] [PATCH v5 2/4] ARM: sunxi: dt: Add DT bindings
 documentation for SUNXI Security System
In-Reply-To: <1413728182-13569-3-git-send-email-clabbe.montjoie@gmail.com>
References: <1413728182-13569-1-git-send-email-clabbe.montjoie@gmail.com>
 <1413728182-13569-3-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <EC763015-19F7-4F25-8694-B1F6798E3B7B@dominion.thruhere.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Op 19 okt. 2014, om 16:16 heeft LABBE Corentin <clabbe.montjoie@gmail.com> het volgende geschreven:
> 
> This patch adds documentation for Device-Tree bindings for the Security System cryptographic accelerator driver.
> 
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
> Documentation/devicetree/bindings/crypto/sunxi-ss.txt | 9 +++++++++
> 1 file changed, 9 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/crypto/sunxi-ss.txt
> 
> diff --git a/Documentation/devicetree/bindings/crypto/sunxi-ss.txt b/Documentation/devicetree/bindings/crypto/sunxi-ss.txt
> new file mode 100644
> index 0000000..a566803
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/sunxi-ss.txt
> @@ -0,0 +1,9 @@
> +* Allwinner Security System found on A20 SoC
> +
> +Required properties:
> +- compatible : Should be "allwinner,sun7i-a20-crypto".
> +- reg: Should contain the Security System register location and length.
> +- interrupts: Should contain the IRQ line for the Security System.
> +- clocks : A phandle to the functional clock node of the Security System module
> +- clock-names : Name of the functional clock, should be "ahb" and "mod".

It would be nice to have a copy/paste ready example node in here, like Boris did in "[PATCH v6 2/2] mtd: nand: add sunxi NFC dt bindings doc".

regards,

Koen
