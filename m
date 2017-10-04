From: olof@lixom.net (Olof Johansson)
Date: Tue, 3 Oct 2017 18:10:03 -0700
Subject: [GIT PULL] Reset controller fixes for v4.14
In-Reply-To: <1506010379.10081.15.camel@pengutronix.de>
References: <1506010379.10081.15.camel@pengutronix.de>
Message-ID: <20171004011003.ae5r55dttjtxrvlj@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 21, 2017 at 06:12:59PM +0200, Philipp Zabel wrote:
> Dear arm-soc-maintainers,
> 
> please consider merging this tag for v4.14. It removes the "v1" suffix
> from the newly merged HSDK reset driver, fixes its Kconfig dependencies,
> and adds back the DT binding documentation that I accidentally dropped
> onto the floor when applying the original patch.
> 
> regards
> Philipp
> 
> The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:
> 
>   Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/pza/linux.git tags/reset-fixes-for-4.14
> 
> for you to fetch changes up to 544e3bf4f0e8278400f19ca7918a3cdf2548b4eb:
> 
>   reset: Restrict RESET_HSDK to ARC_SOC_HSDK or COMPILE_TEST (2017-09-21 12:44:01 +0200)
> 
> ----------------------------------------------------------------
> Reset controller fixes for v4.14
> 
> - Remove misleading HSDK v1 suffix, as there is no v2 planned
> - Add missing DT binding documentation for HSDK reset driver
> - Fix HSDK reset driver dependencies

Merged, thanks.


-Olof
