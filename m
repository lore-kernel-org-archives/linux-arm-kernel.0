From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 20 May 2013 13:08:04 -0600
Subject: [PATCH] ARM: tegra: enable host1x support by default
In-Reply-To: <1368868666-24754-1-git-send-email-acourbot@nvidia.com>
References: <1368868666-24754-1-git-send-email-acourbot@nvidia.com>
Message-ID: <519A7494.1050206@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18/2013 03:17 AM, Alexandre Courbot wrote:
> Tegra DRM support used to be enabled in the default Tegra configuration,
> but it now depends on CONFIG_TEGRA_HOST1X which is disabled by default.
> Enable CONFIG_TEGRA_HOST1X so that DRM support is compiled in again.

I've forwarded this to arm at kernel.org in the hope it can be pulled into
3.10. If not, I'll apply it to the Tegra tree once I hear back.
