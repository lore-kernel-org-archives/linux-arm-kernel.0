From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 17 Oct 2018 16:23:18 +0100
Subject: [PATCH 1/2] perf: arm_spe: Enable automatic DT loading
In-Reply-To: <20181012192409.3819792-1-jeremy.linton@arm.com>
References: <20181012192409.3819792-1-jeremy.linton@arm.com>
Message-ID: <10e23ba4-9bed-5b0c-1659-3f2c69837c06@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks like my previous response for this patch didn't make to the list.

On 12/10/18 20:24, Jeremy Linton wrote:
> When built as a module, the spe driver isn't automatically
> loaded on DT systems. Add the MODULE_DEVICE_TABLE entry.
> 

FWIW,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
