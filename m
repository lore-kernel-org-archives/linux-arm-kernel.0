From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 Nov 2012 10:11:07 -0800
Subject: [GIT PULL 1/3] omap plat header removal for v3.8 merge window,
 part2
In-Reply-To: <508affc9.8f07320a.16f0.0ac0SMTPIN_ADDED@mx.google.com>
References: <508affc9.8f07320a.16f0.0ac0SMTPIN_ADDED@mx.google.com>
Message-ID: <20121105181107.GA22301@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 02:23:39PM -0700, Tony Lindgren wrote:
> The following changes since commit 3e9a6321f9895eac9a3d241d3126e44021e7102b:
> 
>   Merge tag 'omap-for-v3.8/cleanup-headers-signed' into omap-for-v3.8/cleanup-headers-serial-take2 (2012-10-24 13:25:44 -0700)
> 
> are available in the git repository at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-headers-serial-take2-signed
> 
> for you to fetch changes up to 3d82cbbb3aadb4f8a30e3f614e51be96574a0855:
> 
>   ARM: OMAP: Split plat/serial.h for omap1 and omap2+ (2012-10-24 13:34:31 -0700)
> 
> ----------------------------------------------------------------
> These changes remove plat/serial.h usage for omap2+.
> 
> Note that this branch is based on a tty commit 3e9a6321
> (tty/serial/8250: Make omap hardware workarounds local to 8250.h)
> merged with omap-for-v3.8/cleanup-headers-signed.
> 
> The tty commit is needed to keep things compiling for omaps,
> and omap-for-v3.8/cleanup-headers-signed is needed to avoid
> multiple merge conflicts with the includes. I've verified
> with Greg KH that the tty commit above is immutable and OK
> to use as a base.

Thanks, pulled into next/headers, and I kept an explicit dependency on Greg's
tree as depends/tty so we can keep track of it.


-Olof
