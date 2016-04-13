From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Apr 2016 14:17:05 -0700
Subject: [GIT PULL] ARM RealView device tree files
In-Reply-To: <CACRpkdZ1eEC+iDKdRhgXPGKTuoyNCo-bgk1ii62RoqR03_JUtQ@mail.gmail.com>
References: <CACRpkdZ1eEC+iDKdRhgXPGKTuoyNCo-bgk1ii62RoqR03_JUtQ@mail.gmail.com>
Message-ID: <20160413211705.GV19945@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 11:09:13AM +0200, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> here is a set of ARM RealView device tree files that only use
> existing bindings and with all new or controversial stuff stripped
> out.
> 
> This needs to get into linux-next and get some rotation.
> 
> Please pull them to some DTS branch.
> 
> Yours,
> Linus Walleij
> 
> The following changes since commit 9735a22799b9214d17d3c231fe377fc852f042e9:
> 
>   Linux 4.6-rc2 (2016-04-03 09:09:40 -0500)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
> tags/versatile-dts-1
> 
> for you to fetch changes up to dfc8a117388786ab3cfdf0880a09abd05c4e0a4d:
> 
>   ARM: dts: realview: DT support for the PBA8 and PBX-A9 (2016-04-04
> 10:58:05 +0200)
> 
> ----------------------------------------------------------------
> Versatile DTS changes, baseline for the v4.7 series:
> - Add CLCD panel nodes to PB1176 and PB11MPCore
> - Add a DT binding blurb for the Versatile IB2 syscon
> - Add DTS files for the (QEMU supported) RealView EB
>   boards in all variants.
> - Add DTS files for the (QEMU supported) RealView PBA8
>   and PBX-A9 board variants.


Merged, thanks!


-Olof
