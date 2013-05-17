From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 17 May 2013 17:53:45 -0600
Subject: [PATCH] ARM: tegra: add various LED triggers to defconfig
In-Reply-To: <1368834690-1174-1-git-send-email-swarren@wwwdotorg.org>
References: <1368834690-1174-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5196C309.5000903@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/2013 05:51 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> A couple of Tegra boards have gpio-leds present. Enable various trigger
> options to make those useful. This sets all the trigger options to their
> "if you don't know, say X" value.

I have applied this to (squashed it into) Tegra's for-3.11/defconfig branch.
