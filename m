From: olof@lixom.net (Olof Johansson)
Date: Wed, 19 Apr 2017 06:23:37 -0700
Subject: [GIT PULL 2/2] ZTE arm64 device tree changes for 4.12
In-Reply-To: <1491837665-2579-2-git-send-email-shawnguo@kernel.org>
References: <1491837665-2579-1-git-send-email-shawnguo@kernel.org>
 <1491837665-2579-2-git-send-email-shawnguo@kernel.org>
Message-ID: <20170419132337.GJ29219@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 10, 2017 at 11:21:05PM +0800, Shawn Guo wrote:
> The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:
> 
>   Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/zte-dt64-4.12
> 
> for you to fetch changes up to f006aaf7b11230e38a35f09d706e751fa77eb799:
> 
>   arm64: dts: zte: add tvenc device for zx296718 (2017-03-24 16:25:19 +0800)
> 
> ----------------------------------------------------------------
> ZTE arm64 device tree updates for 4.12:
>  - Add mmc devices for ZX296718 SoC and enable those available on
>    zx296718-evb board.
>  - Add VOU controller device, output devices HDMI and TVENC, and enable
>    display support for zx296718-evb board.
>  - Remove pll_vga clock from ZX296718 device tree, as it's not a fixed
>    rate clock.

Merged, thanks.


-Olof
