From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 26 Nov 2012 16:17:26 -0700
Subject: [PATCH V2] ARM: dt: tegra: cardhu: Add drm components
In-Reply-To: <1353396472-24167-1-git-send-email-markz@nvidia.com>
References: <1353396472-24167-1-git-send-email-markz@nvidia.com>
Message-ID: <50B3F886.3090701@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2012 12:27 AM, Mark Zhang wrote:
> This patch adds the rgb node which is needed by
> tegra drm driver.

This doesn't seem to include all the GPIOs/regulators/... required to
enable the panel and backlight.
