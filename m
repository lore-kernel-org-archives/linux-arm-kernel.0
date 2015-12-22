From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 15:00:10 -0800
Subject: [GIT PULL 2/3] ARM: imx: device tree changes for 4.5
In-Reply-To: <1450795558-10961-2-git-send-email-shawnguo@kernel.org>
References: <1450795558-10961-1-git-send-email-shawnguo@kernel.org>
 <1450795558-10961-2-git-send-email-shawnguo@kernel.org>
Message-ID: <20151222230010.GP30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2015 at 10:45:57PM +0800, Shawn Guo wrote:
> Hi arm-soc maintainers,
> 
> This is the i.MX device tree updates for 4.5.  To resolve the dependency
> between clock drivers and DTS files on some new clock ID additions, the
> branches imx/fixes and imx/clk are pulled into the branch.  The clock
> changes have been sent to clk folks as a stable branch.
> 
> Shawn
> 
> The following changes since commit c89dcce4e11c1653ca7954a9dc2839b4d8cd6b4b:
> 
>   Merge branch 'imx/clk' into imx/dt (2015-12-22 20:40:27 +0800)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.5
> 
> for you to fetch changes up to 67fea0f43d151a4688df1fa4c945f72a26dfb545:
> 
>   ARM: dts: imx7d: sbc-imx7: add basic board support (2015-12-22 20:43:43 +0800)
> 
> ----------------------------------------------------------------
> The i.MX device tree updates for 4.5:
> - New boards support: imx51-ts4800, imx6q-novena, CompuLab imx7d SoM/SBC,
>   vf610m4-cosmic
> - Add ADC device support for imx6ul and imx7d
> - Remove config space from PCIe controller ranges property for i.MX6
> - Add Vivante GPU nodes for i.MX6
> - Add DCU, LCD, and SATA devices for LS1021A
> - A series to update Ventana gw5xxx boards getting HDMI and LVDS to work
>   simultaneously and devices like PWM and SPI added
> - Quite a few random cleanups and minor updates

Merged, thanks.


-Olof
