From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 20 Aug 2013 14:32:10 -0600
Subject: [PATCH v3 5/5] clocksource: armada-370-xp: Add detailed clock
 requirements in devicetree binding
In-Reply-To: <1377013554-23389-6-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1377013554-23389-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377013554-23389-6-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <5213D24A.50908@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2013 09:45 AM, Ezequiel Garcia wrote:
> Specifies the required clock inputs for each supported compatible.
> Armada 370 requires a single clock phandle, and Armada XP requires
> two clock phandles with clock-names "nbclk" and "fixed".

This patch,
Acked-by: Stephen Warren <swarren@nvidia.com>

(although the requirement for Armada XP to have entries in
clocks/clock-names isn't backwards-compatible...)
