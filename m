From: olof@lixom.net (Olof Johansson)
Date: Sat, 8 Nov 2014 16:55:26 -0800
Subject: [GIT PULL] at91: cleanup for 3.19 #1
In-Reply-To: <1415037288-4332-1-git-send-email-nicolas.ferre@atmel.com>
References: <1415037288-4332-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20141109005526.GC13855@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 03, 2014 at 06:54:47PM +0100, Nicolas Ferre wrote:
> Arnd, Olof, Kevin,
> 
> The pull-request that was sent late for 3.18. It was removing the old
> !MMU at91x40 and 2 board files plus the whole code in at91sam9g45 & at91sam9rl
> files for implementing this deprecated method. For these particular ones, the
> EK were the only one to use this code.
> We can use these boards with DT right now.
> 
> More code removal like that is shedulle for 3.19, so this is just a first set.
> 
> Thanks, best regards,
> 
> The following changes since commit cac7f2429872d3733dc3f9915857b1691da2eb2f:
> 
>   Linux 3.18-rc2 (2014-10-26 16:48:41 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-cleanup
> 
> for you to fetch changes up to bcf8c7e7703bb2bbde66bec26a81fed4be9cd1d4:
> 
>   ARM: at91: remove at91sam9rl legacy board support (2014-11-03 18:48:02 +0100)
> 
> ----------------------------------------------------------------
> First batch of cleanup/SoC for 3.19:
> - removal of old at91x40 !MMU ARM7TDMI support which was kind of rusty
> - removal of board-sam9m10g45ek.c and board-sam9rlek.c from mach-at91
>   and the code related to these board C files + defconfigs. Use DT for them
>   now!

Merged, thanks!


-Olof
