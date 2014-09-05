From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 05 Sep 2014 11:03:46 -0600
Subject: [PATCH v3 1/2] ARM: tegra: Move pwm and dpaux labels to
 tegra124.dtsi
In-Reply-To: <1409869235-8121-1-git-send-email-dgreid@chromium.org>
References: <1409869235-8121-1-git-send-email-dgreid@chromium.org>
Message-ID: <5409ECF2.8010507@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/04/2014 04:20 PM, Dylan Reid wrote:
> These labels will be used by other boards in addition to Venice2, move
> them to tegra124.dtsi so they are defined in a common place.

I've applied the series to Tegra's for-3.18/dt branch.
