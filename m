From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Sep 2015 16:31:05 -0700
Subject: [GIT PULL] ARM: imx: fixes for 4.3
In-Reply-To: <20150928052440.GA4843@tiger>
References: <20150928052440.GA4843@tiger>
Message-ID: <20150928233105.GA30986@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 28, 2015 at 01:24:41PM +0800, Shawn Guo wrote:
> The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:
> 
>   Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-fixes-4.3
> 
> for you to fetch changes up to 0af822110871400908d5b6f83a8908c45f881d8f:
> 
>   ARM: dts: fix usb pin control for imx-rex dts (2015-09-24 05:13:40 -0700)
> 
> ----------------------------------------------------------------
> The i.MX fixes for 4.3:
>  - One fix for i.MX6 Rex Pro board to remove a duplicated pinctrl entry
>    which causes error for USB pinctrl setup.
>  - Fix MC34708 PMIC interrupt level for imx53-qsrb board.

Merged, thanks.


-Olof
