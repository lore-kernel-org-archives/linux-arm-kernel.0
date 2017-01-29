From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 14:42:46 -0800
Subject: [GIT PULL 2/3] Rockchip dts32 updates for 4.11 part1
In-Reply-To: <1581407.91s7OzFVNJ@phil>
References: <6458001.3c0YmcoF8y@phil>
 <1581407.91s7OzFVNJ@phil>
Message-ID: <20170129224246.GE3133@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 21, 2017 at 01:11:25AM +0100, Heiko Stuebner wrote:
> The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:
> 
>   Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.11-rockchip-dts32-1
> 
> for you to fetch changes up to ec7c98ec9b8dd2c04ed75cad88e91eebedbb1a25:
> 
>   ARM: dts: rockchip: add soc-specific uart compatibles for rk3066/rk3188 (2017-01-19 17:04:44 +0100)
> 
> ----------------------------------------------------------------
> Bit of cleanup for the cortex-a9 uarts to have that soc-specific
> spare-compatible as all others have, conversion to gpio constants
> and addition of rk3288 qos nodes that need to be saved before a
> power-domain gets turned off.

Merged, thanks.


-Olof
