From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 11 Jun 2015 17:36:44 -0700
Subject: [PATCH v2 0/6] SPMI regulator driver
In-Reply-To: <1434069067-1371-1-git-send-email-sboyd@codeaurora.org>
References: <1434069067-1371-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <557A299C.9090307@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2015 05:31 PM, Stephen Boyd wrote:
> This patchset adds support for the regulators found on Qualcomm's
> SPMI PMICs. The first patch is the "basic" driver that doesn't have
> any non-standard features. The next 4 patches add ways to configure some
> of the non-standard features that are generic but aren't supported
> in the regulator framework. And the final patch adds support
> for the non-standard features and some vendor specific features to
> the SPMI regulator driver.
>

Argh, missed an e! Resending...

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
