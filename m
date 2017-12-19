From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Dec 2017 15:12:43 -0200
Subject: [PATCH 3/6] ARM: dts: imx6: Add support for phyBOARD-Mira i.MX
 6Quad/Dual RDK
In-Reply-To: <1513698588-13325-4-git-send-email-s.riedmueller@phytec.de>
References: <1513698588-13325-1-git-send-email-s.riedmueller@phytec.de>
 <1513698588-13325-4-git-send-email-s.riedmueller@phytec.de>
Message-ID: <CAOMZO5BKiQ8MC-LEmWwEYcEXKqLNgcfwc=bki9a3OROyN1P+Fg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 1:49 PM, Stefan Riedmueller
<s.riedmueller@phytec.de> wrote:

> +/ {
> +       model = "PHYTEC phyBOARD-Mira Quad Carrier-Board with eMMC";
> +       compatible = "phytec,imx6q-pbac06-emmc", "phytec,imx6q-pbac06",
> +                    "phytec,imx6qdl-pcm058", "fsl,imx6q";
> +
> +       aliases {
> +               ipu1 = &ipu2;
> +       };

This alias is not needed as it is part of imx6q.dtsi.

> +/ {
> +       model = "PHYTEC phyBOARD-Mira Quad Carrier-Board with NAND";
> +       compatible = "phytec,imx6q-pbac06-nand", "phytec,imx6q-pbac06",
> +                    "phytec,imx6qdl-pcm058", "fsl,imx6q";
> +
> +       aliases {
> +               ipu1 = &ipu2;
> +       };

Ditto.
