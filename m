From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 9 Apr 2013 17:16:35 +0200
Subject: [GIT PULL 8/8] ARM: tegra: defconfig changes
In-Reply-To: <1365181426-11547-8-git-send-email-swarren@wwwdotorg.org>
References: <1365181426-11547-1-git-send-email-swarren@wwwdotorg.org>
 <1365181426-11547-8-git-send-email-swarren@wwwdotorg.org>
Message-ID: <201304091716.36058.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 April 2013, Stephen Warren wrote:
> Various new features are enabled:
> 
> * Tegra114 support.
> * Various PMICs and related options for Tegra114 platforms.
> * KEYBOARD_GPIO, mainly as a suspend wakeup source.
> * tegra_defconfig is rebuilt based on v3.9-rc1, which causes various
>   layout changes.
> 
> This branch is based on v3.9-rc1.

Pulled into next/soc.

I'm currently thinking about creating a next/defconfig branch after all,
since we have a couple of pull requests in next/soc that only do
defconfig changes. Olof, any opinion?

	Arnd
