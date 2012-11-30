From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 30 Nov 2012 12:28:49 -0700
Subject: [PATCH] ARM: dt: tegra: cardhu: Add drm components
In-Reply-To: <1354254256-10212-1-git-send-email-markz@nvidia.com>
References: <1354254256-10212-1-git-send-email-markz@nvidia.com>
Message-ID: <50B908F1.8000407@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2012 10:44 PM, Mark Zhang wrote:
> This patch adds the RGB & HDMI nodes in Tegra 30 cardhu's dts.
> This makes the LVDS & HDMI working.

This still doesn't add any of the backlight/panel GPIO programming,
which I believe is required before we enable any LCDs. We could add the
HDMI node without that though.
