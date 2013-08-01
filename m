From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 01 Aug 2013 12:17:57 -0600
Subject: [PATCH V3] ARM: dts: tegra114: dalmore: fix the irq trigger type
 of Palmas MFD device
In-Reply-To: <1375349865-29816-1-git-send-email-josephl@nvidia.com>
References: <1375349865-29816-1-git-send-email-josephl@nvidia.com>
Message-ID: <51FAA655.7090409@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01/2013 03:37 AM, Joseph Lo wrote:
> The IRQ trigger type of Palmas MFD device (tps65913) is designed as
> low-level sensitive on Dalmore. The wrong configuration would cause an
> interrupt storm when booting the system. Fixing it in DT with appropriate
> interrupt type.

I have applied this to Tegra's for-3.12/dt branch.
