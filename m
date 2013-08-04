From: olof@lixom.net (Olof Johansson)
Date: Sun, 4 Aug 2013 13:38:27 -0700
Subject: [GIT 0/4] Second round of Renesas ARM based SoC fixes for v3.11
In-Reply-To: <cover.1375234088.git.horms+renesas@verge.net.au>
References: <cover.1375234088.git.horms+renesas@verge.net.au>
Message-ID: <20130804203827.GG15602@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 31, 2013 at 10:33:44AM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> please consider the following Renesas ARM based SoC fixes for v3.11.
> 
> The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:
> 
>   Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes2-for-v3.11
> 
> for you to fetch changes up to a601469386b543df2a4d97ad7d524716945278a3:
> 
>   ARM: shmobile: lager: do not annotate gpio_buttons as __initdata (2013-07-31 10:11:17 +0900)
> 
> ----------------------------------------------------------------
> Second round of Renesas ARM based SoC fixes for v3.11
> 
> * Lager board: do not annotate gpio_buttons as __initdata
>   - This avoids accessing uninitialised memory if keys are pressed
>     after kernel initialisation completes.
>   - Bug introduced in gpio-keys were enabled in v3.11-rc1
> 
> * Bock-W board: fix SDHI0 PFC settings
>   - Allow detection of SD card
>   - Bug introduced in SDHI support was added in v3.11-rc1
> 
> * shdma: fixup sh_dmae_get_partial() calculation error
>   - Bug introduced in 2.6.34-rc1.
> 
> * armadillo800eva board: Don't request GPIO 166 in board code
>   - Allow use of touchscreen
>   - Bug introduced in v3.11-rc1

Pulled, thanks for the excellent tag description.


-Olof
