From: olof@lixom.net (Olof Johansson)
Date: Sat, 2 Dec 2017 17:01:57 -0800
Subject: [GIT PULL] i.MX fixes for 4.15
In-Reply-To: <20171130013439.GH22908@dragon>
References: <20171130013439.GH22908@dragon>
Message-ID: <20171203010157.pu7xrx7i3tiuake7@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 30, 2017 at 09:34:40AM +0800, Shawn Guo wrote:
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
> 
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.15
> 
> for you to fetch changes up to e501506d3ea00eefa64463ebd9e5c13ee70990bd:
> 
>   Revert "ARM: dts: imx53: add srtc node" (2017-11-29 10:34:45 +0800)
> 
> ----------------------------------------------------------------
> i.MX fixes for 4.15:
>  - A fix for vf610-zii-dev-rev-c board which correct the unit-address
>    of I2C EEPROM node to match the 'reg' property.
>  - We thought the RTC block on i.MX53 is compatible with the one found
>    on i.MX25, and added the device for i.MX53 device tree.  But it turns
>    out that's not the case, and we have to revert the change.

Great tag description. Merged, thanks.


-Olof
