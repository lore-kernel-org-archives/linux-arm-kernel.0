From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 05 Jan 2015 15:08:40 -0700
Subject: [PATCH] ARM: tegra: use generated pinmux for Beaver board
In-Reply-To: <1420495066-19221-1-git-send-email-dev@lynxeye.de>
References: <1420495066-19221-1-git-send-email-dev@lynxeye.de>
Message-ID: <54AB0B68.7050704@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2015 02:57 PM, Lucas Stach wrote:
> Replace the current incomplete pinmux setup with a proper one generated
> using the tegra pinmux scripts.

I assume this is identical to the existing content, it's just that the 
node sort order changed to match the auto-generation order?

If so,
Acked-by: Stephen Warren <swarren@nvidia.com>
