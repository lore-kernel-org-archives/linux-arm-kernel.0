From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 06 Mar 2013 13:38:34 -0700
Subject: [PATCH] clocksource: tegra: move to of_clk_get
In-Reply-To: <1359985230-11506-1-git-send-email-pdeschrijver@nvidia.com>
References: <1359985230-11506-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <5137A94A.2030203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/2013 06:40 AM, Peter De Schrijver wrote:
> The new clockframework introduced DT IDs for each clock. To be able to remove
> the device registrations, this driver needs to be updated to use the DT IDs.
> Note that the actual removal of the clk_register_clkdev() calls will be done
> in a later series.

I've applied this to Tegra's for-3.10/cleanup branch.
