From: baruch@tkos.co.il (Baruch Siach)
Date: Tue, 6 Dec 2016 15:22:00 +0200
Subject: [RFC PATCH 04/23] arm: use kconfig fragments for ARCH_ASPEED
 defconfigs
In-Reply-To: <1481027938-31831-5-git-send-email-b.zolnierkie@samsung.com>
References: <1481027938-31831-1-git-send-email-b.zolnierkie@samsung.com>
 <1481027938-31831-5-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20161206132200.ruuegdzdv3t4ln2q@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Bartlomiej,

On Tue, Dec 06, 2016 at 01:38:39PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Replace [acs5k,acs5k_tiny,ks8695]_defconfig-s with a Makefile target
> using merge_config.
> 
> The patch was verified with doing:
> 
>     $ make [acs5k,acs5k_tiny,ks8695]_defconfig
>     $ make savedefconfig
> 
> and comparing resulting defconfig files (before/after the patch).

The subject is wrong. Ditto for the mmp/pxa patch.

> Cc: Greg Ungerer <gerg@uclinux.org>
> Cc: Cyril Bur <cyrilbur@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
