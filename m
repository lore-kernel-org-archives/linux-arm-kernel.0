From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 17:14:53 +0200
Subject: [GIT PULL 5/8] ARM: tegra: clock driver development
In-Reply-To: <1365181426-11547-5-git-send-email-swarren@wwwdotorg.org>
References: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
 <1365181426-11547-5-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201304091714.53220.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Stephen Warren wrote:
> This branch contains most fixes and enhancements to the Tegra common
> clock driver. The main new feature is a driver for Tegra114, which
> coupled with later device tree changes enables many devices on that
> chip, such as MMC, I2C, etc.
> 
> This branch depends on a patch in:
> 
> git://git.linaro.org/people/mturquette/linux.git clk-for-3.10

Pulled into next/drivers branch, and noted down the dependency.

As a general recommendation, it is nicer if you can prepare a
separate branch with the dependency, even if it's just one patch,
and have that pulled into both maintainer trees, rather than
having us add the entire set of clk changes as a dependency.

	Arnd
