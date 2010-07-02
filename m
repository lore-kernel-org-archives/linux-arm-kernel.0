From: ben@simtec.co.uk (Ben Dooks)
Date: Fri, 02 Jul 2010 10:41:34 +0100
Subject: [PATCH] ARM: SAMSUNG: Implement set_name function for ADC devices
In-Reply-To: <1277902749-12882-1-git-send-email-kgene.kim@samsung.com>
References: <1277902749-12882-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <4C2DB44E.3090305@simtec.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/06/10 13:59, Kukjin Kim wrote:
> From: Naveen Krishna Ch <ch.naveen@samsung.com>
> 
> This patch implements s3c_adc_setname() for Samsung SoCs.
> Also updates its usage in S3C64XX, S5P6440, and S5PV210.
> 
> Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

assuming we don't fix this another way, then lets go with
this

-- 
Ben
