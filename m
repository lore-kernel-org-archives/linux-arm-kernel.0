From: olof@lixom.net (Olof Johansson)
Date: Sun, 29 Jan 2017 17:15:51 -0800
Subject: [GIT PULL 2/5] omap soc changes for v4.11 merge window
In-Reply-To: <58879774.9c41620a.96bae.6ba2SMTPIN_ADDED_BROKEN@mx.google.com>
References: <pull-1485274191-192300>
 <58879774.9c41620a.96bae.6ba2SMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <20170130011551.GW3133@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 10:05:15AM -0800, Tony Lindgren wrote:
> The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> 
>   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.11/soc-signed
> 
> for you to fetch changes up to 8c4bc910633d942b4422e8b264c39a48e230a261:
> 
>   ARM: OMAP: clock: Remove unused mpurate cmdline option (2017-01-24 07:20:02 -0800)
> 
> ----------------------------------------------------------------
> SoC changes for omaps for v4.11 merge window. This adds support
> for keeping the interconnect target module active for uart if
> earlycon is specified. And we're adding Aaro Koskinen as a
> co-maintainer for omap1 to make sure things stay working for
> omap1. The other changes are mostly clean-up of old legacy code:
> 
> - Remove unused omap_display_init()
> 
> - Make omapdss_find_dss_of_node() function static
> 
> - Add support for earlycon
> 
> - Tidy up omap1 usb logging output with pr_cont
> 
> - Make omap_otg_init() static
> 
> - Delete redundant CPU class checks for omap1
> 
> - Remove unused mpurate cmdline option that has not done
>   anything for past 1.5 years at least
> 

Merged, thanks!


-Olof
