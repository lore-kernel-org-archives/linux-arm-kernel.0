From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 08 Sep 2010 00:17:53 +0100
Subject: [PATCH 1/5] rtc: rtc-s3c: Fix access unit from byte to word on
	RTCCON
In-Reply-To: <1283837381-9575-2-git-send-email-kgene.kim@samsung.com>
References: <1283837381-9575-1-git-send-email-kgene.kim@samsung.com>
	<1283837381-9575-2-git-send-email-kgene.kim@samsung.com>
Message-ID: <4C86C821.9080505@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/10 06:29, Kukjin Kim wrote:
> From: Changhwan Youn <chaos.youn@samsung.com>
> 
> S3C2410_RTCCON of TYPE_S3C64XX RTC should be read/written by readw and writew,
> because TYPE_S3C64XX RTC uses bit8 and bit9.
> 
> Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>

Anyone else tried this on s3c24xx?
