From: olof@lixom.net (Olof Johansson)
Date: Tue, 25 Sep 2018 12:31:12 -0700
Subject: [GIT PULL] ARM: at91: fixes for 4.19
In-Reply-To: <20180924200941.GA11498@piout.net>
References: <20180924200941.GA11498@piout.net>
Message-ID: <20180925193112.uu2lncxsbmzenxl4@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2018 at 10:09:41PM +0200, Alexandre Belloni wrote:
> Arnd, Olof,
> 
> Here is a small fix for an issue seen on the sama5d2 PTC EK.
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux tags/at91-4.19-fixes
> 
> for you to fetch changes up to 379e36d3f591cb62e781907edafea17d75e8c1fa:
> 
>   ARM: dts: at91: sama5d2_ptc_ek: fix nand pinctrl (2018-09-12 12:38:04 +0200)
> 
> ----------------------------------------------------------------
> AT91 fixes for 4.19:
> 
>  - fix a NAND issue on sama5d2_ptc_ek

Merged, thanks (with slight elaboration on merge description from tag).


-Olof
