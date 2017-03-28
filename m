From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 28 Mar 2017 10:23:23 -0600
Subject: [PATCH] arm64: tegra: Add CPU and PSCI nodes for NVIDIA Tegra210
 platforms
In-Reply-To: <1490701718-16571-1-git-send-email-jonathanh@nvidia.com>
References: <1490701718-16571-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <9069e2fd-bf7b-b1df-3d1b-071ee21642ef@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2017 05:48 AM, Jon Hunter wrote:
> Add the CPU and PSCI nodes for the NVIDIA Tegra210 platforms so that
> all CPUs can be enabled on boot. This assumes that the PSCI firmware
> has been loaded during the initial bootstrap on the device before the
> kernel starts (which is typically the case for these platforms). The
> PSCI firmware version is set to v0.2 which aligns with the current
> shipping version for Tegra.

This seems fine, although I'd expect PSCI to be used everywhere on 
Tegra, so putting this in tegra210.dtsi would make more sense.
