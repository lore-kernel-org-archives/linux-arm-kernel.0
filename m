From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 1 Oct 2014 18:04:57 +0200
Subject: [GIT PULL] ARM: brcmstb: SMP, earlyprintk and Kconfig cleanups
In-Reply-To: <1411689248-14074-1-git-send-email-f.fainelli@gmail.com>
References: <1411689248-14074-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <201410011804.57926.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 September 2014, Florian Fainelli wrote:
> This pull request contains 3 changes for the brcmstb platform
> 
> - first patch re-introduces SMP support after fixing the problems we had in
>   the initial implementation, for this patch to apply cleanly, I had to advance
>   up to "ARM: brcmstb: revert SMP support"
> 
> - second patch is dropping unused Kconfig dependencies
> 
> - third patch adds earlyprintk to brcmstb platforms using the existing 8250
>   infrastructure

Pulled into next/late since this was really too late for 3.18.

There is still a chance that it could make it, but don't rely on that.

	Arnd
