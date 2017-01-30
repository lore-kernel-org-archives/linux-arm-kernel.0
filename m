From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 21:07:24 -0800
Subject: [GIT PULL 2/5] i.MX cleanups for 4.11
In-Reply-To: <1485662803-31235-2-git-send-email-shawnguo@kernel.org>
References: <1485662803-31235-1-git-send-email-shawnguo@kernel.org>
 <1485662803-31235-2-git-send-email-shawnguo@kernel.org>
Message-ID: <20170130050724.GQ18943@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2017 at 12:06:40PM +0800, Shawn Guo wrote:
> The following changes since commit 0c744ea4f77d72b3dcebb7a8f2684633ec79be88:
> 
>   Linux 4.10-rc2 (2017-01-01 14:31:53 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-cleanup-4.11
> 
> for you to fetch changes up to 5fdb98dcfb0221f488dd238570933fd3dcfae031:
> 
>   ARM: mach-mx27_3ds: Remove camera support (2017-01-03 13:52:38 +0800)
> 
> ----------------------------------------------------------------
> i.MX cleanup for 4.11:
>  - Remove unused flexcan and esdhc device definitions for i.MX25.
>  - A series from Fabio to remove camera device initialization code from
>    i.MX platform support, since the corresponding media driver has been
>    deprecated and removed from kernel tree.
> 
> ----------------------------------------------------------------
> Arnd Bergmann (1):
>       ARM: imx: remove unused device definitions
> 
> Fabio Estevam (6):
>       ARM: mach-mx31_3ds: Remove camera support
>       ARM: mx31moboard-marxbot: Remove camera support
>       ARM: mx31moboard-smartbot: Remove camera support
>       ARM: mach-mx35_3ds: Remove camera support
>       ARM: mach-pcm037: Remove camera support
>       ARM: mach-mx27_3ds: Remove camera support

Merged, thanks.

Did camera support on this platform get completely removed, or was it
a migration to a newer driver?


-Olof
