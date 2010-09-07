From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 08 Sep 2010 00:21:50 +0100
Subject: [PATCH 2/5] rtc: rtc-s3c: Fix setting missing field of getalarm
In-Reply-To: <1283837381-9575-3-git-send-email-kgene.kim@samsung.com>
References: <1283837381-9575-1-git-send-email-kgene.kim@samsung.com>
	<1283837381-9575-3-git-send-email-kgene.kim@samsung.com>
Message-ID: <4C86C90E.1050905@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/10 06:29, Kukjin Kim wrote:
> From: Changhwan Youn <chaos.youn@samsung.com>
> 
> Current s3c_rtc_getalarm() sets missing field of alarm time with 0xff.
> But this value should be -1 according to drivers/rtc/interface.c.

Never noticed a problem, but then this call isn't the most used
call.

> Signed-off-by: Changhwan Youn <chaos.youn@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
Acked-By: Ben Dooks <ben-linux@fluff.org>
