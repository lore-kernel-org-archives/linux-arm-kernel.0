From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 12 Dec 2013 12:35:37 -0700
Subject: [PATCH] ARM: tegra: add clock properties for devices of Tegra124
In-Reply-To: <1381218460-23123-1-git-send-email-josephl@nvidia.com>
References: <1381218460-23123-1-git-send-email-josephl@nvidia.com>
Message-ID: <52AA1009.70706@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/08/2013 01:47 AM, Joseph Lo wrote:
> This patch adds clock properties for devices in the DT for basic support
> of Tegra124 SoC.

I've applied this to Tegra's for-3.14/dt branch, with one minor fixup to
add a unit address to /clocks/clock in tegra124-venice2.dts.
