From: olof@lixom.net (Olof Johansson)
Date: Fri, 25 May 2018 04:58:30 -0700
Subject: [GIT PULL 1/3] DaVinci SoC updates for v4.18
In-Reply-To: <20180517130845.863-1-nsekhar@ti.com>
References: <20180517130845.863-1-nsekhar@ti.com>
Message-ID: <20180525115830.ltodmaldiwkxqna5@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 06:38:43PM +0530, Sekhar Nori wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.18/soc
> 
> for you to fetch changes up to ccfadbb759bed3cc40336e2c486e619e3bf8590b:
> 
>   Merge branch 'v4.18/nand-cs-simplification' into v4.18/soc (2018-05-02 15:04:15 +0530)
> 
> ----------------------------------------------------------------
> DaVinci SoC support updates for v4.18
> 
> Mainly contains patches to move NAND chipselect to platform data
> (currently platform device id is being used). These patches have
> been acked by NAND maintainer and because of the driver dependency
> an immutable branch has been provided to Boris.
> 
> The other patch is to remove an unnecessary postcore_initcall() on
> DM644x which is needed for common clock framework conversion.

Merged, thanks.


-Olof
