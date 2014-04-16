From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 16 Apr 2014 17:14:58 -0600
Subject: [PATCH] ARM: tegra: make Venice's +3.3V_RUN regulator always
 on
In-Reply-To: <1397600984-25198-1-git-send-email-swarren@wwwdotorg.org>
References: <1397600984-25198-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <534F0EF2.9030209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2014 04:29 PM, Stephen Warren wrote:
> This regulator supplies power to pretty much everything on the board, so
> it doesn't make sense to allow it to turn off. Mark it boot-on and
> always-on so it doesn't get turned off. Without this, I see issues with
> the eMMC device; it can't be correctly detected during boot.

I've applied this to Tegra's for-3.16/dt branch.
