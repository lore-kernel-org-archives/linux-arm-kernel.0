From: olof@lixom.net (Olof Johansson)
Date: Mon, 14 May 2018 09:26:47 -0700
Subject: [GIT PULL] ARM: mvebu: fixes for v4.17 (#1)
In-Reply-To: <87zi123adf.fsf@bootlin.com>
References: <87zi123adf.fsf@bootlin.com>
Message-ID: <20180514162647.yoyjidyzgayyru3w@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 10:33:00AM +0200, Gregory CLEMENT wrote:
> Hi,
> 
> Here is the first pull request for fixes for mvebu for v4.17.
> 
> Gregory
> 
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.17-1
> 
> for you to fetch changes up to f43194c1447c9536efb0859c2f3f46f6bf2b9154:
> 
>   ARM64: dts: marvell: armada-cp110: Add mg_core_clk for ethernet node (2018-04-27 17:47:24 +0200)
> 
> ----------------------------------------------------------------
> mvebu fixes for 4.17 (part 1)
> 
> Declare missing clocks needed for network on Armada 8040 base boards
> (such as the McBin)

Thanks!

How well should I expect mcbin to work with a mainline kernel now? I
still use the 4.4 mcbin kernel on mine in "production" (I use one for
all my maintainer work). What's missing from that kernel on mainline?


-Olof
