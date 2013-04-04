From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 04 Apr 2013 12:20:35 -0600
Subject: [PATCH] clk: tegra: Use common of_clk_init() function
In-Reply-To: <1365066351-2395-1-git-send-email-pgaikwad@nvidia.com>
References: <1365066351-2395-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <515DC473.8000104@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2013 03:05 AM, Prashant Gaikwad wrote:
> Use common of_clk_init() function for clocks initialization.
> 
> Signed-off-by: Prashant Gaikwad <pgaikwad@nvidia.com>
> ---
> 
> Stephen, if T114 clock series is not going to make in 3.10 then I would
> like Mike to take this patch. If T114 clock series makes it then I have
> to rebase this patch on top of it.

I'm still just hopeful that it the Tegra114 support can get into 3.10;
all I'm waiting on is Mike's ack to apply it. Let's hold off on this
patch until after that. Thanks.
