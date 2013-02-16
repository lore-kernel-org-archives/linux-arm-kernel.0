From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 16 Feb 2013 10:34:33 +0000
Subject: GIT PULL] Renesas ARM-based SoC pinmux for v3.9 #2
In-Reply-To: <1360981553-11414-1-git-send-email-horms+renesas@verge.net.au>
References: <1360981553-11414-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <201302161034.33865.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 February 2013, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> The following changes since commit c3323806a67c0c656e27956b7340e37ba6c6968b:
> 
>   sh-pfc: Move sh_pfc.h from include/linux/ to driver directory (2013-01-25 09:24:31 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-pinmux2-for-v3.9
> 
> for you to fetch changes up to 8c43fcc7804fc4609ccd9fa021e21f5423db9d96:
> 
>   sh-pfc: sh_pfc_probe() sizeof() fix (2013-02-16 10:58:50 +0900)
> 
> ----------------------------------------------------------------
> Bug fix from Magnus that resolves a regression introduced in pfc changes
> queued up for 3.9.


Pulled into next/sh-pinux, thanks!

Olof, we haven't done an official handover, but since I have added a couple of
my own bug fixes in the past days, and I say no other updates from you, I decided
to take this one in. I'll also have a look if there are more fixes to take care
of over the weekend.

	Arnd
