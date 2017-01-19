From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 19 Jan 2017 13:49:59 +0000
Subject: [PATCH v9 0/4] arm64: arch_timer: Add workaround for
 hisilicon-161010101 erratum
In-Reply-To: <1484832916-7248-1-git-send-email-dingtianhong@huawei.com>
References: <1484832916-7248-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <23512329-e8d9-4b4f-c460-4d769ef7102e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/01/17 13:35, Ding Tianhong wrote:
> Erratum Hisilicon-161010101 says that the ARM generic timer counter "has the
> potential to contain an erroneous value when the timer value changes".
> Accesses to TVAL (both read and write) are also affected due to the implicit counter
> read.  Accesses to CVAL are not affected.

Please. 3 series in 2 hours is not fun, and is not helping your case
either. Give us the time to properly review your patches, and wait until
we ask you to respin if we think that this is required.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
