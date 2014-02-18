From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 18 Feb 2014 15:11:48 -0700
Subject: [PATCH] ARM: tegra: Add head numbers to display controllers
In-Reply-To: <1392761011-21701-1-git-send-email-thierry.reding@gmail.com>
References: <1392761011-21701-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <5303DAA4.3090608@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2014 03:03 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The number of the head specifies the index of the display controller
> unit and is required to properly configure outputs so that they receive
> video data from the correct source.

Acked-by: Stephen Warren <swarren@nvidia.com>
