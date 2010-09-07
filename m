From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 08 Sep 2010 00:22:46 +0100
Subject: [PATCH 3/5] rtc: rtc-s3c: Fix on support RTC Alarm
In-Reply-To: <1283837381-9575-4-git-send-email-kgene.kim@samsung.com>
References: <1283837381-9575-1-git-send-email-kgene.kim@samsung.com>
	<1283837381-9575-4-git-send-email-kgene.kim@samsung.com>
Message-ID: <4C86C946.10500@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/10 06:29, Kukjin Kim wrote:
> From: Changhwan Youn <chaos.youn@samsung.com>
> 
> The alarm_irq_enable function should be implemented to support RTC alarm.
> And fixes tab instead of white space abound proc field.
> 
> Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>

oops. wonder how long that's been broken for.
Acked-by: Ben Dooks <ben-linux@fluff.org>
