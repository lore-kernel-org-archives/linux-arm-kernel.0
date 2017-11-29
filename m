From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 29 Nov 2017 22:11:41 +0100
Subject: [PATCH] rtc: brcmstb-waketimer: fix error handling in
 brcmstb_waketmr_probe()
In-Reply-To: <1510953358-7043-1-git-send-email-khoroshilov@ispras.ru>
References: <1510953358-7043-1-git-send-email-khoroshilov@ispras.ru>
Message-ID: <20171129211141.GR21126@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/11/2017 at 00:15:58 +0300, Alexey Khoroshilov wrote:
> brcmstb_waketmr_probe() does not disable timer->clk on error paths.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> ---
>  drivers/rtc/rtc-brcmstb-waketimer.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
