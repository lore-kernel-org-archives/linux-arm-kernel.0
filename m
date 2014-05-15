From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 15 May 2014 13:22:00 -0600
Subject: [RFC PATCH 04/10] clk: tegra: Initialize xusb clocks
In-Reply-To: <1400113986-339-5-git-send-email-abrestic@chromium.org>
References: <1400113986-339-1-git-send-email-abrestic@chromium.org>
 <1400113986-339-5-git-send-email-abrestic@chromium.org>
Message-ID: <537513D8.7060203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2014 06:33 PM, Andrew Bresticker wrote:
> Initialize the XUSB-related clocks with appropriate parents and rates
> for both Tegra114 and Tegra124.

These first 4 clock driver patches look plausible to me, although I
didn't look that hard!

Peter or Mike, if they look OK to you, can you please pick them up for
3.16 so that by the time we apply the rest of the patches in this series
for 3.17, the clock dependencies are already there? Thanks.
