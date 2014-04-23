From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 23 Apr 2014 15:44:53 +0800
Subject: [PATCH v2] staging: imx-drm-core: skip components whose parent
 device is disabled
In-Reply-To: <20140422215506.GC24070@n2100.arm.linux.org.uk>
References: <1397440946-2303-1-git-send-email-shawn.guo@freescale.com>
 <CAOesGMiDqd+JSd_fzzeWohSGixuR1ciOz_FO5CGnSm7F3ioxDw@mail.gmail.com>
 <20140421233148.GZ2523@dragon> <201404222249.07486.arnd@arndb.de>
 <20140422215506.GC24070@n2100.arm.linux.org.uk>
Message-ID: <20140423074451.GE2523@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 10:55:06PM +0100, Russell King - ARM Linux wrote:
> So care to explain why there were _zero_ merge conflicts from -rc time
> before the merge window up to about a week _into_ the merge window, and
> then suddenly arm-soc starts conflicting not only locally here but _also_
> in linux-next.
> 
> That stinks of arm-soc merging new stuff *during* the merge window.

I'm not sure that's the case.

It seems to me that the merge conflict was reported by Stephen Rothwell
one month ahead of the merge window [1].

Shawn

[1] https://lkml.org/lkml/2014/2/25/21

> 
> And don't try to deny that - remember, I run a build system here locally,
> and I _manually_ merge Linus' tip into my tip (which contains *everything*
> including the staged changes for imx-drm and those binding changes) _and_
> finally arm-soc's for-next branch, and there were _zero_ conflicts at the
> start of the merge window.
