From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 30 Jul 2015 14:48:48 -0700
Subject: [PATCH 1/2] ARM: BCM5301X: activate some additional options in
 pl310 cache controller
In-Reply-To: <1438206660-30718-1-git-send-email-hauke@hauke-m.de>
References: <1438206660-30718-1-git-send-email-hauke@hauke-m.de>
Message-ID: <55BA9BC0.70601@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/07/15 14:50, Hauke Mehrtens wrote:
> In the default Broadcom SDK the shared override is activated for this
> cache controller, do the same in the upstream code. Data and
> instruction prefetching is not activated by default for this cache
> controller on the bcm53xx SoC, do it manually like it is done in the
> vendor SDK.
> 
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Applied to devicetree/next, thanks!
-- 
Florian
