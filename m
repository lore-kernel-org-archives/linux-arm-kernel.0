From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 03 Sep 2013 11:57:05 -0600
Subject: [PATCH] clk: tegra: replace enum tegra114_clk by binding header
In-Reply-To: <1378213915-10222-1-git-send-email-pdeschrijver@nvidia.com>
References: <1378213915-10222-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <522622F1.70008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/2013 07:11 AM, Peter De Schrijver wrote:
> As the clock IDs are now specified in a header file, we can use those
> definitions instead of maintaining an internal enum.

Acked-by: Stephen Warren <swarren@nvidia.com>

I assume this will go through Mike's clock tree for 3.13.

I assume similar patches will follow for Tegra20/30?
