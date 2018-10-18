From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Oct 2018 09:56:09 +0100
Subject: [PATCH] arm: kernel: add support for detecting armv8 cpu cache
 information
In-Reply-To: <1539843407-7439-1-git-send-email-tengfei@codeaurora.org>
References: <1539843407-7439-1-git-send-email-tengfei@codeaurora.org>
Message-ID: <20181018085609.GI30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 18, 2018 at 02:16:47PM +0800, Teng Fei Fan wrote:
> This patch adds support for cacheinfo on 32bit ARMv8 platform.
> Add support for detecting cpu cache information cpu cache information
> via sysfs for 32bit armv8 platform. And export to sysfs then userspace
> can get from /sys/devices/system/cpu/cpuX/cache.

You don't explain why this is needed.

We don't do this for previous 32-bit CPUs, so why should we do this
for ARMv8 running on a 32-bit kernel?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
