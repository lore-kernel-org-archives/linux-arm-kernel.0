From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 23 Jan 2018 10:14:41 +0000
Subject: [PATCH -next] cpufreq: scpi: fix error return code in
 scpi_cpufreq_init()
In-Reply-To: <1516673342-170261-1-git-send-email-weiyongjun1@huawei.com>
References: <1516673342-170261-1-git-send-email-weiyongjun1@huawei.com>
Message-ID: <15661228-4bb6-233e-b81b-8f51f4579616@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 23/01/18 02:09, Wei Yongjun wrote:
> Fix to return a negative error code from the clk_get() error handling
> case instead of 0, as done elsewhere in this function.
> 

Thanks for catching this.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
