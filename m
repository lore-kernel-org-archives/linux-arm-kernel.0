From: olof@lixom.net (Olof Johansson)
Date: Tue, 22 Dec 2015 11:49:34 -0800
Subject: [GIT PULL] ARM: imx: fixes for 4.4, 3rd round
In-Reply-To: <20151217085049.GA9161@tiger>
References: <20151217085049.GA9161@tiger>
Message-ID: <20151222194934.GE30172@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 04:50:49PM +0800, Shawn Guo wrote:
> The following changes since commit 9c17190595840b4ed30e8d5f286636ceb28aae4f:
> 
>   ARM: dts: vf610: use reset values for L2 cache latencies (2015-12-11 21:32:47 +0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.4-3
> 
> for you to fetch changes up to 3a35e470bc6bc4ce34c19c410ebbe4e3bbf0bafe:
> 
>   ARM: dts: imx6: Fix Ethernet PHY mode on Ventana boards (2015-12-15 16:53:15 +0800)
> 
> ----------------------------------------------------------------
> The i.MX fixes for 4.4, 3rd round:
> - Fix Ethernet PHY mode on i.MX6 Ventana boards, which can result in
>   a non-functional Ethernet when Marvell phy driver rather than generic
>   phy driver is selected.
> - Fix an assigned-clock configuration bug on imx6qdl-sabreauto board
>   which was introduced by commit ed339363de1b ("ARM: dts:
>   imx6qdl-sabreauto: Allow HDMI and LVDS to work simultaneously").

Merged, thanks.


-Olof
