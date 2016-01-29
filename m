From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 29 Jan 2016 10:21:24 +0100
Subject: [PATCH] arm64: add Kconfig entry for LG1K SoC family
In-Reply-To: <1454058895-4884-1-git-send-email-chanho.min@lge.com>
References: <1454058895-4884-1-git-send-email-chanho.min@lge.com>
Message-ID: <3614541.oUWpW74d41@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 January 2016 18:14:55 Chanho Min wrote:
> This patch introduces ARCH_LG1K to enable LG Electronics's LG1K SoC
> family in Kconfig.
> 
> The dts and defconfig will be submitted soon in another series.
> 
> Signed-off-by: Chanho Min <chanho.min@lge.com>

Please keep this together with the defconfig change for now if you want
to send a git pull request. If you send separate patches, just keep it
all together as a series. Also add a patch to list an entry in the
MAINTAINERS file.

In either case, submit it to the mailing lists for review first, but
once the patches are ready to be applied, send them "To: arm at kernel.org"
with everyone else on Cc.

	Arnd
