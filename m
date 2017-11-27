From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 27 Nov 2017 18:18:40 -0200
Subject: [PATCH 00/13] SolidRun Hummingboard DT updates
In-Reply-To: <20171127165134.GH31757@n2100.armlinux.org.uk>
References: <20171127165134.GH31757@n2100.armlinux.org.uk>
Message-ID: <CAOMZO5DY+6BkaFSVHg-mbZ6_vcM_wcwin16WmPbp22p1AX4yzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 2:51 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> Hi Shawn,
>
> This series updates the SolidRun Hummingboard platforms to:
> (a) make the DT more reflective of the schematics
> (b) re-organise how we deal with the differences between various board
>     versions in preparation for the new 1.5 microsom.
>
> The idea with (b) is that we add the support for the board + usom
> combination by including the appropriate dtsi files.
>
> For example, in mainline at the moment, we support two variants of the
> Hummingboards - both with Broadcom Wi-Fi and without eMMC.  Going
> forward, when a 1.5 usom is fitted (which modern Hummingboards will all
> have) the boards will have TI Wi-Fi and potentially eMMC on the usom.
>
> So, this prepares the ground to support these combinations, and maybe
> if I can get agreement from Jon, move forward with Hummingboard2
> support.

Looks good. Only a few minor nits that I found and replied in the
respective patches.

For the whole series:

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
