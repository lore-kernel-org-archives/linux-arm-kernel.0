From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 Jan 2015 14:46:01 -0800
Subject: [GIT PULL 2/3] ARM: imx: device tree changes for 3.20
In-Reply-To: <20150123091641.GC27337@dragon>
References: <20150123091641.GC27337@dragon>
Message-ID: <20150123224601.GP20896@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 05:16:43PM +0800, Shawn Guo wrote:
> Hi Arnd, Olof,
> 
> Please note this change set depends on imx-soc-3.20, thanks.
> 
> Shawn
> 
> The following changes since commit c205389557aac828f8403db0368d1fc2ef859213:
> 
>   ARM: imx: clk-vf610: Add clock for SNVS (2015-01-13 19:16:26 +0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-3.20
> 
> for you to fetch changes up to 16baf8ddd84b36e6880092da777a67de362f8677:
> 
>   ARM: dts: imx28-evk: remove duplicate property (2015-01-20 19:39:28 +0800)
> 
> ----------------------------------------------------------------
> The i.MX device tree update for 3.20:
>  - Update i.MX6 operating-points setting in device tree to match the
>    latest i.MX6 data sheet
>  - Add i.MX6SX sabreauto board support
>  - Add imx6dl-udoo board support based off imx6q-udoo
>  - Update sabrelite board to include I2C and HDMI support
>  - Update the VPU compatible strings to also use cnm,coda<model>
>  - Remove the ocram clock from the VPU node, as the clock is already
>    provided inside the ocram node
>  - Add system reset controller and syscon-reboot for VF610
>  - Update VF610 device tree to use zero based naming for GPIO nodes,
>    so that the number scheme matches hardware manual
>  - A number of random device additions like watchdog for VF610, sahara
>    for i.MX53, QSPI for imx6sx-sdb board, etc.
> 
> Note: the branch imx/soc was merged into imx/dt because the SNVS device
> tree node needs to refer to the new clock ID added by the imx/soc patch.

Merged, thanks. I checked in a trivial patch on top to sort some of the 6q
entries.


-Olof
