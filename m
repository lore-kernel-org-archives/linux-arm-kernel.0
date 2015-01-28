From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Wed, 28 Jan 2015 09:59:13 +0100
Subject: [PATCH v4 00/13] AT91 pm cleanup for 3.20
In-Reply-To: <1422409172-24178-1-git-send-email-wenyou.yang@atmel.com>
References: <1422409172-24178-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20150128085913.GA7742@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Wenyou,

On Wed, Jan 28, 2015 at 09:39:32AM +0800, Wenyou Yang wrote:
> Hi Nicolas,
> 
> This version is rebased on the branch: at91-3.20-cleanup of the repository
> 	git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git
> 
> It is purpose to clean up the PM code, includes the patches from Peter Rosin and Sylvain Rochet.
> 
> Since verifying the USB clock and USB PLL disabling before suspending to memory,
> it aslo depends on the following patch serials from Sylvain:
> 	[PATCHv6 0/5] USB: gadget: atmel_usba_udc: Driver improvements
> 	[PATCHv7 0/6] USB: host: Atmel OHCI and EHCI drivers improvements
> 
> Removes CONFIG_AT91_SLOW_CLOCK config item to simply the PM config,
> The suspend to standby mode uses the same sram function as the suspend to memory mode.
> Remove some unused code.
> 
> Alexandr & Sylvain, Thank you very much for so many feedbacks.
> 
> Changes in v2:
>  - Rebase on the at91-3.20-cleanup branch
>  - Recover the verify clock condition, only for suspend to memory.
>  - Collect ACK from Alexandre
>  - Add the macro for PM mode
> 
> Changes in v3:
>  - Clear unused state argument in at91_pm_verify_clocks()
>  - Remove pr_info("AT91:... slow_clock ? ..") in patch 07/13.

Changes in v4: ? :-)

Sylvain
