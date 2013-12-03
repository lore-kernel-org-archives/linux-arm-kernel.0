From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 03 Dec 2013 12:57:53 -0700
Subject: [PATCH] clk: tegra: Correct clock number for UARTE
In-Reply-To: <1385983825-20317-1-git-send-email-treding@nvidia.com>
References: <1385983825-20317-1-git-send-email-treding@nvidia.com>
Message-ID: <529E37C1.601@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/2013 04:30 AM, Thierry Reding wrote:
> UARTE has clock number 66. Number 65 is the right one for UARTD.

Reviewed-by: Stephen Warren <swarren@nvidia.com>
