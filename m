From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Apr 2014 10:04:13 -0600
Subject: [PATCH 0/7] ARM: tegra: HDMI and DSI updates
In-Reply-To: <1398440691-23366-1-git-send-email-thierry.reding@gmail.com>
References: <1398440691-23366-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <535E7BFD.60708@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2014 09:44 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This series enables support for HDMI on Venice2 and Jetson TK1. It also
> adds the missing +5V regulators for Harmony, Beaver and Dalmore. Other
> boards may also need similar changes, but I don't have access to them.
> That said existing boards should continue to work without modifications
> since we were completely ignoring the +5V regulator before. So the only
> change that this should introduce is that perhaps some additional power
> can be saved because the +5V regulator now isn't always on.
> 
> The final patch in this series hooks up the DSI power supply on Dalmore
> so that it can also be switched of if not used.

I've applied the series to Tegra's for-3.16/dt branch.
