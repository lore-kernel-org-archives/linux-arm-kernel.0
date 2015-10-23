From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 23 Oct 2015 11:16:42 +0100
Subject: [patch] cpufreq: scpi-cpufreq: signedness bug in
 scpi_get_dvfs_info()
In-Reply-To: <20151022195208.GB24439@mwanda>
References: <20151022195208.GB24439@mwanda>
Message-ID: <562A090A.5000703@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 22/10/15 20:52, Dan Carpenter wrote:
> The "domain" variable needs to be signed for the error handling to
> work.
>
> Fixes: 8def31034d03 ('cpufreq: arm_big_little: add SCPI interface
> driver') Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>

Thanks for the fix
Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
