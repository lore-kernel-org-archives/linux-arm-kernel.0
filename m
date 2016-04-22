From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 22 Apr 2016 08:37:54 -0700
Subject: [GIT PULL] Renesas ARM Based SoC Fixes for v4.6
In-Reply-To: <cover.1461209970.git.horms+renesas@verge.net.au> (Simon Horman's
 message of "Thu, 21 Apr 2016 13:44:30 +1000")
References: <cover.1461209970.git.horms+renesas@verge.net.au>
Message-ID: <7hmvol4pt9.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon Horman <horms+renesas@verge.net.au> writes:

> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these Renesas ARM based SoC fixes for v4.6.
>
>
> The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:
>
>   Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes-for-v4.6
>
> for you to fetch changes up to c531fb27e9699eaee478ee5686a3cca5dee73602:
>
>   ARM: shmobile: timer: Fix preset_lpj leading to too short delays (2016-04-20 08:52:55 +1000)
>
> ----------------------------------------------------------------
> Renesas ARM Based SoC Fixes for v4.6
>
> * Correct preset_lpj calculation which may lead to too short delays
> * Correct handling of optional clocks on r8a7791 to restore
>   access to the serial port the porter board
>
> ----------------------------------------------------------------

Applied to fixes,

Kevin
