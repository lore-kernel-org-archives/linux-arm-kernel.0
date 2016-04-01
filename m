From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 31 Mar 2016 20:05:35 -0600
Subject: [PATCH 2/4] ARM: bcm2835: Enable CONFIG_PM.
In-Reply-To: <1459470643-9070-2-git-send-email-eric@anholt.net>
References: <1459470643-9070-1-git-send-email-eric@anholt.net>
 <1459470643-9070-2-git-send-email-eric@anholt.net>
Message-ID: <56FDD76F.5010803@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/31/2016 06:30 PM, Eric Anholt wrote:
> The power domain driver we've enabled doesn't actually do anything
> without it, and we need it to do its job for VC4 to initialize
> successfully.

Patches 1, 2, and 3,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
