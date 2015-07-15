From: olof@lixom.net (Olof Johansson)
Date: Wed, 15 Jul 2015 10:01:05 -0400
Subject: [GIT PULL] omap fixes against v4.2-rc2
In-Reply-To: <20150715105053.GC17550@atomide.com>
References: <20150715105053.GC17550@atomide.com>
Message-ID: <20150715140105.GA6469@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 03:50:53AM -0700, Tony Lindgren wrote:
> The following changes since commit bc0195aad0daa2ad5b0d76cce22b167bc3435590:
> 
>   Linux 4.2-rc2 (2015-07-12 15:10:30 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.2/fixes-rc2-v2
> 
> for you to fetch changes up to 9908ac3daa3da2d236b5406b95d0865ddb8b29c4:
> 
>   ARM: dts: Correct audio input route & set mic bias for am335x-pepper (2015-07-15 03:03:01 -0700)
> 
> ----------------------------------------------------------------
> Fixes for omaps, all dts changes except for one:
> 
> - Fix up LCD panel name for overo boards
> 
> - Three fixes for pepper board for regulators, freqeuncy
>   scaling and audio input. Note that there is still one
>   issue being worked on for booting with multi_v7_defconfig
> 
> - Add missing #iommu-cells for omap4 and 5
> 
> - Add missing HAVE_ARM_SCU for am43xx

Merged, thanks.


-Olof
