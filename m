From: olof@lixom.net (Olof Johansson)
Date: Sat, 19 May 2018 17:58:46 -0700
Subject: [GIT PULL] arm64: tegra: Device tree fixes for v4.17
In-Reply-To: <20180517160436.12180-1-thierry.reding@gmail.com>
References: <20180517160436.12180-1-thierry.reding@gmail.com>
Message-ID: <20180520005846.nss24q7oqi4sbvmc@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 06:04:36PM +0200, Thierry Reding wrote:
> Hi ARM SoC maintainers,
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.17-fixes-2
> 
> for you to fetch changes up to 9df50ba76ac1485b844beffa1f3f5d9659d9cdaf:
> 
>   arm64: tegra: Make BCM89610 PHY interrupt as active low (2018-05-03 11:48:16 +0200)
> 
> Thanks,
> Thierry
> 
> ----------------------------------------------------------------
> arm64: tegra: Device tree fixes for v4.17
> 
> This contains a one-line update to the device tree of the Tegra186 P3310
> processor module, fixing the polarity of the PHY interrupt. Originally,
> this was queued to go into v4.18, but the PHY ID matching patch has now
> found its way into v4.17-rc5, which means that the PHY driver will know
> how to identify the PHY on this board and try to use the interrupt. This
> will unfortunately cause networking to break on P3310, hence why I think
> this should go into v4.17.

Merged, thanks.


-Olof
