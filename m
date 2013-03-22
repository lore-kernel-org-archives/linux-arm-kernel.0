From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Mar 2013 16:36:05 +0000
Subject: [BUGFIX PATCH] ARM: OMAP: fix type of return values in
 omap_device_get_by_hwmod_name()
In-Reply-To: <1363867990-24593-1-git-send-email-LW@KARO-electronics.de>
References: <1363867990-24593-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <20130322163605.GM30923@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 01:13:10PM +0100, Lothar Wa?mann wrote:
> The merge bda5e141fbe96295c669692114d18687730269fb erroneously changed

Don't forget that commit's description as well...
