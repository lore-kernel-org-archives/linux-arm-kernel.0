From: olof@lixom.net (Olof Johansson)
Date: Thu, 4 Jan 2018 23:19:04 -0800
Subject: [GIT PULL 3/3] Allwinner arm64 defconfig changes for 4.16
In-Reply-To: <20171228063248.GA4228@wens.csie.org>
References: <20171228062444.GA3883@wens.csie.org>
 <20171228063248.GA4228@wens.csie.org>
Message-ID: <20180105071904.vqzzbby47nhfbx26@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 28, 2017 at 02:32:48PM +0800, Chen-Yu Tsai wrote:
> The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:
> 
>   Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-config64-for-4.16
> 
> for you to fetch changes up to 051db633571b10c7112be00df83d5aee8d0f706e:
> 
>   arm64: defconfig: enable MUSB HDRC along with Allwinner glue (2017-12-07 09:46:13 +0100)
> 
> ----------------------------------------------------------------
> Allwinner arm64 defconfig changes for 4.16
> 
> Enables MUSB driver and the Allwinner glue layer driver by default.
> 
> All Allwinner SoCs (excluding the A80) have the Mentor Graphics Inventra
> Multi-Point Hi-Speed OTG Controller (MHDRC). Enabling this extends test
> coverage to this peripheral.

Merged, thanks.


-Olof
