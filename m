From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Apr 2014 10:05:10 -0600
Subject: [PATCH] ARM: tegra: use correct audio CODEC on Jetson TK1
In-Reply-To: <1398443012-17212-1-git-send-email-swarren@wwwdotorg.org>
References: <1398443012-17212-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <535E7C36.8020206@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25/2014 10:23 AM, Stephen Warren wrote:
> Jetson TK1 contains an RT5639 not an RT5640. While the two are extremely
> similar and mostly compatible, we should still use the correct device
> name in the device tree. I had meant to fix this before applying the
> initial DT, but this issue slipped my mind.

I have applied this to Tegra's for-3.16/dt branch.
