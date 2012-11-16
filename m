From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 16 Nov 2012 09:18:14 -0700
Subject: [PATCH 0/3] ARM: tegra: Enable HDMI on Tamonten carriers
In-Reply-To: <1353081412-19448-1-git-send-email-thierry.reding@avionic-design.de>
References: <1353081412-19448-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <50A66746.6090805@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2012 08:56 AM, Thierry Reding wrote:
> The three patches in this series enable the HDMI output on Plutux and
> TEC. The Medcom-Wide only has an LVDS output and the TEC has an LVDS
> output as well, but since they depend on the videomode helpers and the
> power-sequences patch series, they will only be enabled in subsequent
> patches.

Thanks, I've applied the series to Tegra's for-3.8/dt branch.
