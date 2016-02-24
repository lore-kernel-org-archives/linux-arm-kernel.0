From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Feb 2016 13:53:28 -0800
Subject: [GIT PULL 4/4] rockchip dts32 changes for 4.6
In-Reply-To: <22050679.RDDVtpO0ps@phil>
References: <1734524.3yNt5L3F1F@phil>
 <22050679.RDDVtpO0ps@phil>
Message-ID: <20160224215328.GN10126@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 11, 2016 at 04:12:35PM +0100, Heiko Stuebner wrote:
> Hi Arnd, Olof, Kevin,
> 
> and finally this is the biggest set ... 32bit devicetree changes.
> For the clock-ids this includes a shared branch that gets shared
> with the clock-branch sent to the clock-maintainers.
> 
> As the tag describes, contents are pretty diverse but simple changes.
> 
> 
> Thanks
> Heiko
> 
> 
> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
> 
>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.6-rockchip-dts32-1
> 
> for you to fetch changes up to 741d3b0c1f6187dbf9b509b6776c77828d4c66d5:
> 
>   ARM: dts: cros-ec-keyboard: Add LOCK key to keyboard matrix (2016-02-10 22:41:53 +0100)
> 
> ----------------------------------------------------------------
> Assorted bunch of 32bit Rockchip devicetree changes. More clocks,
> nodes and fixes like the increased drive-strength on the firefly.
> Most interesting is maybe the enablement of the pl330 option
> for handling the broken flushp operation that is present on the
> current Rockchip SoCs. Together with the driver-side enablement
> this should give us working dma finally.

Merged, thanks!


-Olof
