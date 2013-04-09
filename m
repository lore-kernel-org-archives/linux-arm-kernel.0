From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 21:35:36 +0200
Subject: [PATCHv2] ARM: Push selects for TWD/SCU into machine entries
In-Reply-To: <201304092032.18885.arnd@arndb.de>
References: <1362007694-3419-1-git-send-email-sboyd@codeaurora.org>
 <5164462E.4010706@codeaurora.org> <201304092032.18885.arnd@arndb.de>
Message-ID: <201304092135.36616.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 April 2013, Arnd Bergmann wrote:
> I've applied it to the next/soc branch now.
> 

I just made up my mind again after I got a few merge conflicts. I have
added it to the next/multiplatform branch now instead of next/soc, since
a few of the Kconfig entries changed in this patch are moved to other
files in that branch.

I've also added an entry for mach-zynq, which has gained SMP support
in the meantime. I assume it uses TWD/SCU as it is otherwise rather close
to the ARM reference platforms.

	Arnd
