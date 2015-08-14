From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 14 Aug 2015 14:28:30 -0300
Subject: [PATCH v3] ARM: configs: Add Freescale LS1021A defconfig
In-Reply-To: <55CE1FFE.2080200@freescale.com>
References: <1438941784-38403-1-git-send-email-b18965@freescale.com>
 <55CB4829.40204@freescale.com> <55CE1FFE.2080200@freescale.com>
Message-ID: <CAOMZO5By_15OCsb7z2pbywPi3n9vKGj=393hWYHVEQ32=jDNaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 2:06 PM, Horia Geant?
<horia.geanta@freescale.com> wrote:

> Another thing:
> Commit 385c0fb0e2c4 ("ARM: imx_v6_v7_defconfig: Select LS1021A") added
> CONFIG_SOC_LS1021A in imx_v6_v7_defconfig.
>
> Besides this, booting a LS1021 AQDS board (Rev2) using
> imx_v6_v7_defconfig did not work (stuck at "Starting kernel").

What would be the recommended approach?

- Fix imx_v6_v7_defconfig so that it can make LS1021A to boot

or

- Use this proposed ls1021a_defconfig and remove LS1021A from
imx_v6_v7_defconfig?

Regards,

Fabio Estevam
