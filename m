From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 21 Sep 2015 19:01:53 -0700
Subject: [PATCH v2 2/4] clk: bcm2835: Add binding docs for the new
 platform clock driver.
In-Reply-To: <1441922305-2298-2-git-send-email-eric@anholt.net>
References: <1441922305-2298-1-git-send-email-eric@anholt.net>
 <1441922305-2298-2-git-send-email-eric@anholt.net>
Message-ID: <5600B691.9000401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/2015 02:58 PM, Eric Anholt wrote:
> Previously we've only supported a few fixed clocks based on
> assumptions about how the firmware sets up the clocks, but this
> binding will let us control the actual (audio power domain) clock
> manager.

Patches 1 and 2,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
