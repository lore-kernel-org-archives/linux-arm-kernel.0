From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 6 Mar 2018 17:13:46 +0000
Subject: [PATCH v7 04/13] arm64/acpi: Create arch specific cpu to acpi id
 helper
In-Reply-To: <20180228220619.6992-5-jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
 <20180228220619.6992-5-jeremy.linton@arm.com>
Message-ID: <6763fdb6-92ac-c9cd-0cbc-e641e785b2d9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 28/02/18 22:06, Jeremy Linton wrote:
> Its helpful to be able to lookup the acpi_processor_id associated
> with a logical cpu. Provide an arm64 helper to do this.
> 

This patch on it's own is good, but it's quite generic and made to look
at it again. Sorry for missing this earlier.

Can we use "per_cpu(processors, cpu)->acpi_id" at call sites instead ?
Or you can make that a generic helper using above expression ?

-- 
Regards,
Sudeep
