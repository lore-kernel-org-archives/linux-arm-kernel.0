From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Dec 2010 16:34:53 +0100
Subject: [PATCH 7/7] msm: Build support for the MSM8960 target
In-Reply-To: <1292384961-8851-8-git-send-email-stepanm@codeaurora.org>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1292384961-8851-8-git-send-email-stepanm@codeaurora.org>
Message-ID: <201012151634.53301.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 December 2010, Stepan Moskovchenko wrote:
> Add the Kconfig options and Makefile options needed to
> build for the MSM8960 target. Only the simulator is
> supported at this time.
> 
> Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>

There is no need to split the Makefile/Kconfig changes
from the actual files implementing the functionality.
It's better to keep these together, since neither of the
patches does anything meaningful by itself.

Splitting out the cleanup as you did is good though, it
helps with review and with possible bisection or rebase
of the patches.

	Arnd
