From: nm@ti.com (Nishanth Menon)
Date: Fri, 1 Apr 2016 08:07:49 -0500
Subject: [PATCH] extcon: palmas: Drop stray IRQF_EARLY_RESUME flag
In-Reply-To: <56FDB09A.8000202@samsung.com>
References: <1459458951-4882-1-git-send-email-nm@ti.com>
 <56FDB09A.8000202@samsung.com>
Message-ID: <56FE72A5.9050705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On 03/31/2016 06:19 PM, Chanwoo Choi wrote:
> Don't need to add the IRQF_ONE_SHOT flag for "palmas_usb_id" interrupt?
> If don't need it, I'll merge it on extcon-fixes and then send the pull request for rc cycle.
It does not. This just fixes the remaining IRQF_EARLY_RESUME that was
missed in commit ae64e42cc2b3 ("extcon: palmas: Drop IRQF_EARLY_RESUME
flag")

I will resumbit a v2 with updates from Lee as well.

-- 
Regards,
Nishanth Menon
