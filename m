From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Thu, 3 May 2012 20:48:13 +0100
Subject: [PATCH 1/1] ARM: tegra: Add Tegra Memory Controller(MC) driver
In-Reply-To: <4FA2D0C4.4020608@wwwdotorg.org>
References: <1336063897-12083-1-git-send-email-hdoyu@nvidia.com>
 <4FA2D0C4.4020608@wwwdotorg.org>
Message-ID: <20120503204813.7fe6cd00@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Honestly, to me it seems best to keep purely platform-specific drivers
> like this in arch/arm/mach-tegra, since that's the most closely
> Tegra-related directory.

Or add a drivers/platform/tegra directory ?
