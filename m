From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 15 Jan 2018 13:46:18 +0000
Subject: [PATCH v6 04/12] arm64/acpi: Create arch specific cpu to acpi id
 helper
In-Reply-To: <20180113005920.28658-5-jeremy.linton@arm.com>
References: <20180113005920.28658-1-jeremy.linton@arm.com>
 <20180113005920.28658-5-jeremy.linton@arm.com>
Message-ID: <20180115134618.GD5473@e107155-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 06:59:12PM -0600, Jeremy Linton wrote:
> Its helpful to be able to lookup the acpi_processor_id associated
> with a logical cpu. Provide an arm64 helper to do this.
> 

Makes sense to me, but wondering if we need a weak implementation for
CONFIG_ACPI. Anyways, will check when this gets used in the series.

Not sure if this can be squashed into the patch using it, anyways looks
good on its own.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
