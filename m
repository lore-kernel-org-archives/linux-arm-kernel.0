From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 14 Sep 2016 00:33:11 -0300
Subject: [PATCH v4 2/5] ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual
 initial support
In-Reply-To: <1473618641-10159-3-git-send-email-jagan@amarulasolutions.com>
References: <1473618641-10159-1-git-send-email-jagan@amarulasolutions.com>
 <1473618641-10159-3-git-send-email-jagan@amarulasolutions.com>
Message-ID: <CAOMZO5A+282J_KepDjCU8ai7LYWPSvOeR7ns5uMgTS74FHaMOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 11, 2016 at 3:30 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:

> +&gpmi {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_gpmi_nand>;
> +       fsl,legacy-bch-geometry;

I don't see this property documented nor used anywhere.
