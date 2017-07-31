From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 31 Jul 2017 13:20:31 -0700
Subject: [GIT PULL] Meson clock fixes for 4.13-rc4
In-Reply-To: <ce41382f-fd93-1dc9-0dba-1484ac555945@baylibre.com>
References: <ce41382f-fd93-1dc9-0dba-1484ac555945@baylibre.com>
Message-ID: <20170731202031.GK2146@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31, Neil Armstrong wrote:
> Hi Mike, Stephen,
> 
> Here is some fixes for Meson GXBB and Meson8 drivers, that could go for 4.13-rc4.
> 

Are any of these critical fixes for regressions in the v4.13-rc
series? All the Fixes tags look like they go back to before
v4.13-rc1, so they don't look critical at first glance. If
anything, they're mostly nice to have non-critical fixes? If so,
can we defer these until the next merge window?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
