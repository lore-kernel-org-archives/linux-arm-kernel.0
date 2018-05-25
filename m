From: olof@lixom.net (Olof Johansson)
Date: Fri, 25 May 2018 13:59:13 -0700
Subject: [GIT PULL] Allwinner H3/H5 changes for 4.18
In-Reply-To: <20180521095517.liyqgj32d3xd7ejq@flea>
References: <20180521095517.liyqgj32d3xd7ejq@flea>
Message-ID: <20180525205913.yuntcqsm56z3xz7d@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2018 at 11:55:17AM +0200, Maxime Ripard wrote:
> Hi Arnd, Olof,
> 
> Here is our usual PR with the changes that apply to the H3 and H5,
> shared between arm and arm64.
> 
> Maxime
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git tags/sunxi-h3-h5-for-4.18
> 
> for you to fetch changes up to 06139c822c5011ff79341000f44eca96151aac92:
> 
>   ARM: dts: sun8i: h3: Add SY8106A regulator to Orange Pi PC (2018-05-11 10:00:28 +0200)
> 
> ----------------------------------------------------------------
> Allwinner H3/H5 support for 4.18
> 
> Here is our usual bunch of changes for the H3 and H5 SoCs that share the
> same SoC design but with different CPUs.
> 
> This time, most of the changes are about supporting CPUFreq on these SoCs,
> with voltage scaling being enabled for a number of boards.

Merged, thanks!

-Olof
