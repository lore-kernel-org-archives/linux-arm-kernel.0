From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 20 Jul 2018 16:10:22 -0300
Subject: [PATCH 2/2] ARM: dts: imx6q-icore-mipi: Use 1.5 version of i.Core
 MX6
In-Reply-To: <1532081765-29910-3-git-send-email-jacopo@jmondi.org>
References: <1532081765-29910-1-git-send-email-jacopo@jmondi.org>
 <1532081765-29910-3-git-send-email-jacopo@jmondi.org>
Message-ID: <CAOMZO5B-X48v9-YmeLd91TZf7-+p1w3hKdXZvrnq0gn3yFxPuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2018 at 7:16 AM, Jacopo Mondi <jacopo@jmondi.org> wrote:
> The "EDIMM STARTER KIT i.Core 1.5 MIPI Evaluation" is based on the 1.5 version
> of the i.Core MX6 cpu module. The 1.5 version differs from the original one for
> a few details, including the ethernet PHY interface clock provider.
>
> With this commit, the ethernet interface works properly:
> SMSC LAN8710/LAN8720 2188000.ethernet-1:00: attached PHY driver
>
> While before using the 1.5 version, ethernet failed to startup do to un-clocked
> PHY interface:
> fec 2188000.ethernet eth0: could not attach to PHY
>
> Fixes: commit 3fe088357731 ("ARM: dts: imx6q: Add Engicam i.CoreM6 1.5 Quad/Dual MIPI starter kit support")

Nit: the "commit" word should be removed from the Fixes line.

>

Also, no need to add a blank line after the Fixes tag.

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

> Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
