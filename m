From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 Oct 2015 10:55:46 -0700
Subject: [GIT PULL 2/3] ARM: imx: device tree changes for 4.4
In-Reply-To: <1445267937-2952-2-git-send-email-shawnguo@kernel.org>
References: <1445267937-2952-1-git-send-email-shawnguo@kernel.org>
 <1445267937-2952-2-git-send-email-shawnguo@kernel.org>
Message-ID: <20151023175546.GB18961@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 11:18:56PM +0800, Shawn Guo wrote:
> Hi arm-soc maintainers,
> 
> This is the i.MX device tree updates for 4.4.  To resolve the dependency
> between clock drivers and DTS files on some new clock ID additions, the
> i.MX clock change set imx-clk-4.4 are pulled into the branch.  The clock
> changes has been pulled by Stephen and will be stable.
> 
> Shawn
> 
> 
> The following changes since commit 84a87250ee4e4f7cf5865be9757e2ea758e5cae3:
> 
>   clk: imx6: Add SPDIF_GCLK clock in clock tree (2015-10-12 21:55:59 +0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.4
> 
> for you to fetch changes up to 607e266c47ef552b6f87c7cf0ba7f3c28ea5af14:
> 
>   ARM: dts: ls1021a: Add quirk for Erratum A009116 (2015-10-19 22:45:43 +0800)
> 
> ----------------------------------------------------------------
> The i.MX device tree changes for 4.4:
>  - Add IOMUXC LPSR (Low Power State Retention) device for i.MX7D.
>  - Add a few low power mode related devices and touch controller for
>    i.MX6UL.
>  - Add a number of devices for i.MX7D SDB board support, USB, Dual FEC,
>    and eMMC5.0.
>  - i.MX6 Boundary Devices updates: relicense under GPLv2/X11, add Okaya
>    LCD, touch and wifi support, add new boards Nitrogen6_Lite and
>    Nitrogen6_Max.
>  - Enable touch screen and NAND Flash controller for a few Vybrid
>    devices.
>  - Some random and small updates on LS1021A and MXS support.

Merged, thanks!

Since you specified the dependent branch name, I could easily stage that on the
side too (we prefer to keep a copy of the branch in our tree since it's easier
to tell what dependencies there are).

So this was merged into next/dt, and I also setup a depends/imx-clk branch that
contains imx-clk-4.4.


-Olof
