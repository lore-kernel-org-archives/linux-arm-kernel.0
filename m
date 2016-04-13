From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Apr 2016 11:12:10 -0700
Subject: [GIT PULL] Reset controller changes for v4.7: shared resets
In-Reply-To: <1459414004.4005.10.camel@pengutronix.de>
References: <1459414004.4005.10.camel@pengutronix.de>
Message-ID: <20160413181210.GI19945@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 10:46:44AM +0200, Philipp Zabel wrote:
> Dear arm-soc maintainers,
> 
> this tag adds reference counted shared reset support for multiple
> consumers that use the same reset line for low power states.
> Also there is a cleanup patch for lpc18xx removing global variables.
> 
> This is a rebased version of the late reset-for-4.6-2 tag. The patches
> are reordered so that Hans can base his USB changes on the reset/shared
> branch (reset-for-4.7~1) once this is merged into arm-soc.
> 
> regards
> Philipp
> 
> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
> 
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
> 
> are available in the git repository at:
> 
>   git://git.pengutronix.de/git/pza/linux.git tags/reset-for-4.7
> 
> for you to fetch changes up to 773fe72630c8aca874ec8a07ebacace4ae305a02:
> 
>   reset: lpc18xx: get rid of global variables for restart notifier (2016-03-30 15:42:07 +0200)

By the way, your key doesn't seem to exist on the keyservers. Can you please
get it signed and uploaded?


Thanks,


-Olof
