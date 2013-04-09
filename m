From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 13:01:04 +0200
Subject: [GIT PULL 1/8] ARM: tegra: DT-related fixes needed by the MMC tree
In-Reply-To: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
References: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201304091301.04472.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Stephen Warren wrote:
> In order to convert the Tegra MMC driver to using mmc_of_parse(), some
> bugs in the Tegra device-tree content need to be fixed first; it's
> currently wrong but unused, and mmc_of_parse() causes that data to be
> used for the first time.
> 
> (This branch has also been merged into the MMC tree. I'm sending it as a
> separate pull request as an FYI, but you can feel free to skip it and just
> pull in 2/8 which is the main Tegra fixes branch and includes this)
> 

Pulled into next/dt for completeness, thanks!

	Arnd
