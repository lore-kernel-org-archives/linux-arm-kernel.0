From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 8 Apr 2013 16:38:02 +0200
Subject: [GIT PULL] ux500 multiplatform tags
In-Reply-To: <CACRpkdbPZ5Nvv9+Bz9UE-U6-9QpqAr6UKGyYrTAxj78SJaknvg@mail.gmail.com>
References: <CACRpkdbPZ5Nvv9+Bz9UE-U6-9QpqAr6UKGyYrTAxj78SJaknvg@mail.gmail.com>
Message-ID: <20130408143802.GD21256@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Mon, Apr 08, 2013 at 02:52:42PM +0200, Linus Walleij wrote:
> Hi ARM SoC folks and Sam,
> 
> These are the two multiplatform tags for MFD and ARM SoC.
> 
> As agreed there is one tag for a number of MFD patches that
> remove the <mach/*> dependencies from the DB8500 PRCMU
> driver, then another tag dependent on the former that from that
> point switches to multiplatform.
> 
> Below are two tags on git request-pull formar: the first one
> is for *both* trees, MFD and ARM SoC, the second is only
> for ARM SoC.
> 
> I have moved a few hunks and introduced a new patch in the
> MFD series to make things compile and bisect properly.
> Notably the patch "mfd: db8500-prcmu: drop unused includes"
> is a new one, but the end result is textually equivalent to what
> has already been posted so I consider this a reviewed patch
> set and the split as plain mechanics.
> 
> Please pull your applicable branches!
> 
> Yours,
> Linus Walleij
> 
> 
> MFD tag:
> 
> 
> The following changes since commit a937536b868b8369b98967929045f1df54234323:
> 
>   Linux 3.9-rc3 (2013-03-17 15:59:32 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
> tags/ux500-multiplatform-mfd
Pulled to my mfd-next tree. This is much appreciated, thanks a lot.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
