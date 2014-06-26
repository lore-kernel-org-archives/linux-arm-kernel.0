From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 26 Jun 2014 09:52:16 -0600
Subject: [PATCH] clk: tegra: export clock names for debugging
In-Reply-To: <1403797705-26910-1-git-send-email-pdeschrijver@nvidia.com>
References: <1403797705-26910-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <53AC41B0.40307@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/26/2014 09:48 AM, Peter De Schrijver wrote:
> When writing a module for testing or debugging purposes, there is no way to
> get hold of clk handles. This patch solves this by exposing all valid clocks
> as clkdev's for the virtual device tegra-clk-debug.

This is to support clk_get_sys()?

I guess this seems fine, so feel free to apply it, but I slightly wonder
why not just include this change as part of the presumably local and
never-to-be-upstreamed test/dev module?
