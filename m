From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 Nov 2012 10:31:50 -0800
Subject: [GIT PULL 2/3] omap plat header removal for v3.8 merge window,
 part3
In-Reply-To: <508aff60.4688e50a.0457.ffff898bSMTPIN_ADDED@mx.google.com>
References: <pull-1351286620-406688>
 <508aff60.4688e50a.0457.ffff898bSMTPIN_ADDED@mx.google.com>
Message-ID: <20121105183150.GB22301@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 02:23:40PM -0700, Tony Lindgren wrote:
> The following changes since commit 3d82cbbb3aadb4f8a30e3f614e51be96574a0855:
> 
>   ARM: OMAP: Split plat/serial.h for omap1 and omap2+ (2012-10-24 13:34:31 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-headers-part3-signed
> 
> for you to fetch changes up to a0212796b58061a9716178d261f318925c246643:
> 
>   Merge tag 'omap-cleanup-fixes-a-for-3.8' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.8/cleanup-headers (2012-10-26 13:18:19 -0700)
> 
> ----------------------------------------------------------------
> 
> Here is the third set of plat header removal for omap2+.
> 
> This is based on the following minimal topic branches
> coordinated with the related driver maintainers:
> 
> omap-for-v3.8/cleanup-headers-usb
> omap-for-v3.8/cleanup-headers-menelaus
> 
> In addition to that, there are few fixes to the previously
> merged patches that can show up with customized configs.

Thanks, I pulled in the two branches above as explicit dependencies, and
resolved the conflicts the same way you did.

New branches are:

depends/omap-cleanup-headers-menelaus
depends/omap-cleanup-headers-usb
omap/cleanup-headers-3

-Olof
