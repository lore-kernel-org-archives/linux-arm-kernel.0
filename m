From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 21 Nov 2013 13:29:58 -0700
Subject: [PATCH] clk: tegra: add FUSE clock device
In-Reply-To: <1385001490-18927-1-git-send-email-acourbot@nvidia.com>
References: <1385001490-18927-1-git-send-email-acourbot@nvidia.com>
Message-ID: <528E6D46.7090406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2013 07:38 PM, Alexandre Courbot wrote:
> This clock is needed to ensure the FUSE registers can be accessed
> without freezing the system.

Acked-by: Stephen Warren <swarren@nvidia.com>
