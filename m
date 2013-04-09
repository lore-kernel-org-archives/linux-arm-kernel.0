From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 16:37:53 +0200
Subject: [GIT PULL 4/8] ARM: tegra: core SoC support development
In-Reply-To: <1365181426-11547-4-git-send-email-swarren@wwwdotorg.org>
References: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
 <1365181426-11547-4-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201304091637.53857.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Stephen Warren wrote:
> This branch includes major development on the core Tegra SoC support code
> in the mach-tegra directory:
> 
> * SMP support for Tegra114.
> * Exposes SoC chip ID and revision through standard sysfs files.
> * System-level suspend/resume for Tegra20/30. At present, this only
>   supports "LP2" mode (CPU power-down), but provides the basis to
>   implement "LP0"/"LP1" (various levels of core/chip power-down) in the
>   hopefully near future.
> * A minor cleanup of a duplicate include, which was introduced in this
>   branch.
> 
> This branch is based on the previous cleanup pull request.

Pulled into next/soc, thanks!

	Arnd
