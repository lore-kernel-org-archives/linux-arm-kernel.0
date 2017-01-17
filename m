From: olof@lixom.net (Olof Johansson)
Date: Mon, 16 Jan 2017 21:46:24 -0800
Subject: [GIT PULL] Allwinner fixes for 4.10
In-Reply-To: <20170110175124.oqlucb6a2qut2ten@lukather>
References: <20170110175124.oqlucb6a2qut2ten@lukather>
Message-ID: <20170117054624.GB16607@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 06:51:24PM +0100, Maxime Ripard wrote:
> Hi Arnd, Olof,
> 
> Please pull the following changes for 4.10.
> 
> Thanks!
> Maxime
> 
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-fixes-for-4.10
> 
> for you to fetch changes up to 3116d37651d77125bf50f81f859b1278e02ccce6:
> 
>   ARM: dts: sunxi: Change node name for pwrseq pin on Olinuxino-lime2-emmc (2017-01-10 18:33:16 +0100)
> 
> ----------------------------------------------------------------
> Allwinner fixes for 4.10
> 
> A few fixes here and there to enable the build of some DT leftover, prevent
> display issues or setup a proper muxing.
> 
> ----------------------------------------------------------------
> Chen-Yu Tsai (2):
>       ARM: dts: sun6i: Disable display pipeline by default
>       ARM: dts: sun6i: hummingbird: Enable display engine again
> 
> Emmanuel Vadot (1):
>       ARM: dts: sunxi: Change node name for pwrseq pin on Olinuxino-lime2-emmc
> 
> Milo Kim (1):
>       ARM: dts: sun8i: Support DTB build for NanoPi M1

Merged, thanks.


-Olof
