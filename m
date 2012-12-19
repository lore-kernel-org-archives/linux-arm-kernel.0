From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 19 Dec 2012 10:09:21 -0700
Subject: [PATCH] rtc: tegra: convert to DT driver
In-Reply-To: <1355885237-4448-1-git-send-email-josephl@nvidia.com>
References: <1355885237-4448-1-git-send-email-josephl@nvidia.com>
Message-ID: <50D1F4C1.7060207@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/18/2012 07:47 PM, Joseph Lo wrote:
> After Kernel 3.7, the Tegra device will only support booting with DT. The
> legacy Tegra RTC platform driver will not work anymore. This patch convert
> the driver to support DT.

I think Andrew Morton usually ends up picking up drivers/rtc/ patches
since Alessandro hasn't been active recently. But since Andrew wasn't
Cc'd, I'd be happy to take this through the Tegra tree for 3.9.
