From: olof@lixom.net (Olof Johansson)
Date: Fri, 3 Apr 2015 13:57:06 -0700
Subject: [GIT PULL 1/4] ARM: imx: cleanup for 4.1
In-Reply-To: <CAAQ0ZWQXUJ0O+WBojuoTscW0L1tAGxR3JWYL0=7Jaej5D7zGJw@mail.gmail.com>
References: <CAAQ0ZWQXUJ0O+WBojuoTscW0L1tAGxR3JWYL0=7Jaej5D7zGJw@mail.gmail.com>
Message-ID: <20150403205706.GJ23023@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 10:02:09PM +0800, Shawn Guo wrote:
> The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:
> 
>   Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git
> tags/imx-cleanup-4.1
> 
> for you to fetch changes up to dc98b0cb6175016f31c8ef1685dd0d69476aa495:
> 
>   ARM: imx_v4_v5_defconfig: Remove CONFIG_MACH_MX25_3DS (2015-03-13
> 22:14:59 +0800)
> 
> ----------------------------------------------------------------
> The i.MX cleanup for v4.1:
>  - Convert i.MX25 to be a DT only platform and remove the code that is
>    only used by non-DT support
>  - A couple trivial cleanup on iomux-v3 code

Nice cleanup. Merged, thanks.


-Olof
