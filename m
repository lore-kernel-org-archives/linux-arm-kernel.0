From: varkabhadram@gmail.com (Varka Bhadram)
Date: Mon, 28 Jul 2014 14:37:28 +0530
Subject: [PATCH v4 1/6] rtc: sun6i: Add sun6i RTC driver
In-Reply-To: <1406535661-25072-2-git-send-email-wens@csie.org>
References: <1406535661-25072-1-git-send-email-wens@csie.org>
 <1406535661-25072-2-git-send-email-wens@csie.org>
Message-ID: <53D612D0.6030404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2014 01:50 PM, Chen-Yu Tsai wrote:
> This patch introduces the driver for the RTC in the Allwinner A31 and
> A23 SoCs.
>
> Unlike the RTC found in A10/A20 SoCs, which was part of the timer, the
> RTC in A31/A23 are a separate hardware block, which also contain a few
> controls for the RTC block hardware (a regulator and RTC block GPIO pin
> latches), while also having separate interrupts for the alarms.
>
> The hardware is different enough to make a different driver for it.
>
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---

Reviewed-by: Varka Bhadram <varkabhadram@gmail.com>

-- 
Regards,
Varka Bhadram.
