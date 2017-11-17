From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 17 Nov 2017 15:51:40 -0800
Subject: [PATCH] rtc: brcmstb-waketimer: fix error handling in
 brcmstb_waketmr_probe()
In-Reply-To: <1510953358-7043-1-git-send-email-khoroshilov@ispras.ru>
References: <1510953358-7043-1-git-send-email-khoroshilov@ispras.ru>
Message-ID: <ec00086a-1e5d-a72e-77ea-a93f27f7244e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/17/2017 01:15 PM, Alexey Khoroshilov wrote:
> brcmstb_waketmr_probe() does not disable timer->clk on error paths.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>

Fixes: c4f07ecee22e ("rtc: brcmstb-waketimer: Add Broadcom STB wake-timer")
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
