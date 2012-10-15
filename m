From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Oct 2012 12:05:17 -0600
Subject: [PATCH] ARM: tegra: move tegra-ahb.h out of arch/arm/mach-tegra/
In-Reply-To: <1348091708-6622-1-git-send-email-swarren@wwwdotorg.org>
References: <1348091708-6622-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <507C505D.6020003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/19/2012 03:55 PM, Stephen Warren wrote:
> We wish to empty arch/arm/mach-tegra/include/mach/ as much as possible
> to enable single zImage. Move tegra-ahb.h to a more central location
> (suggested by Arnd, OK'd by Greg KH), and actually make tegra-ahb.c
> include the header to ensure client and provider agree on the prototype.

Applied to Tegra's for-3.8/cleanup branch.
