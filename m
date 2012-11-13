From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Nov 2012 12:50:50 +0000
Subject: [GIT PULL] Renesas ARM-based SoC for v3.8 #4
In-Reply-To: <1352776212-3211-1-git-send-email-horms@verge.net.au>
References: <1352776212-3211-1-git-send-email-horms@verge.net.au>
Message-ID: <201211131250.50883.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 November 2012, Simon Horman wrote:
> please consider the following SoC fixes for 3.8.
> Its a little embarrassing, but they all fix problems introduced
> in previous pull-requests for 3.8 that have been merged.

No problem at all, thanks for the quick follow-up!

> * The three Revert patches back-out secondary CPU initialisation
>   changes from Bastian Hecht which he as advised me are incorrect
>   and break secondary CPU initialisation.
> 
> * The clkfwk patch from Morimoto-san resolves a build warning.
> 
> This pull-request is based on the renesas/soc3 branch in the arm-soc tree.

Pulled into next/soc2, on top of the previous branch.

	Arnd
