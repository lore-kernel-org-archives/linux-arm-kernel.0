From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Thu, 24 Nov 2016 12:36:20 +0300
Subject: [PATCH 7/9] clocksource/drivers/rockchip_timer: implement
 clocksource timer
In-Reply-To: <1479922177-20136-7-git-send-email-al.kochet@gmail.com>
References: <1479922177-20136-1-git-send-email-al.kochet@gmail.com>
 <1479922177-20136-7-git-send-email-al.kochet@gmail.com>
Message-ID: <FFD6E644-F68B-4880-BC76-88F6063D070E@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> In order to use the patch you have to setup the timer using
> 'rockchip,clocksource' device tree property

Just came in mind, that it is better to replace 'rockchip,clocksource' device tree property
with KConfig option in order to enable clocksource on dedicated timer?

Someting like:
[ ] enable clocksource
   clocksource timer name:

Any feedback would be appreciated.

Alexander.
