From: olof@lixom.net (Olof Johansson)
Date: Mon, 26 Jan 2015 20:29:01 -0800
Subject: [GIT PULL 1/2] omap non-urgent fixes for v3.20, part 2
In-Reply-To: <54c6ad8d.8182440a.13ff.15c1SMTPIN_ADDED_BROKEN@mx.google.com>
References: <54c6ad8d.8182440a.13ff.15c1SMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <20150127042901.GJ22154@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 26, 2015 at 01:08:18PM -0800, Tony Lindgren wrote:
> The following changes since commit 13efcb188984f69e1f97b4d9e7d3663fb782946f:
> 
>   ARM: OMAP2+: Disable omap3 PM init for ti81xx (2015-01-14 17:37:16 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.20/fixes-not-urgent-pt2
> 
> for you to fetch changes up to 20d9448a59770420ead8078fb76948de32765fe6:
> 
>   Merge tag 'for-v3.20/omap-hwmod-a' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.20/fixes-not-urgent (2015-01-21 16:52:17 -0800)
> 
> ----------------------------------------------------------------
> Non-critical fixes for omap hwmod code via Paul Walmsley <paul@pwsan.com>:
> 
> First set of OMAP2+ hwmod patches for Linux v3.20.  These are mostly
> fixes for warnings, although there's one DRA7xx patch that fixes
> CONFIG_DEBUG_LL for AM572x/DRA7xx SoCs that use UART3 for console,
> such as the BeagleBoard-X15.
> 
> These patches entered Linux-next starting with the next-20150121 tag.
> 
> Basic build, boot, and PM test results can be found here:
> 
> http://www.pwsan.com/omap/testlogs/omap-hwmod-a-for-v3.20/20150121142621/

Merged, thanks.

-Olof
