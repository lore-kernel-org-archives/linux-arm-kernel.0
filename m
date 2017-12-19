From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 19 Dec 2017 15:15:19 -0200
Subject: [PATCH 5/6] ARM: dts: imx6: Add support for phyBOARD-Mira with
 i.MX 6QuadPlus
In-Reply-To: <1513698588-13325-6-git-send-email-s.riedmueller@phytec.de>
References: <1513698588-13325-1-git-send-email-s.riedmueller@phytec.de>
 <1513698588-13325-6-git-send-email-s.riedmueller@phytec.de>
Message-ID: <CAOMZO5AfdSBOQY4oaH73RDj==2DkFA+=ALL67sjzcqCJegsb_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 19, 2017 at 1:49 PM, Stefan Riedmueller
<s.riedmueller@phytec.de> wrote:

> +/ {
> +       model = "PHYTEC phyBOARD-Mira QuadPlus Carrier-Board with NAND";
> +       compatible = "phytec,imx6qp-pbac06-nand", "phytec,imx6qp-pbac06",
> +                    "phytec,imx6qdl-pcm058", "fsl,imx6qp";
> +
> +       aliases {
> +               ipu1 = &ipu2;
> +       };

Same comment as previous patch. You can drop this alias.
