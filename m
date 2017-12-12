From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 12 Dec 2017 02:12:11 +0100
Subject: [PATCH v5 6/9] ACPI/PPTT: Add topology parsing code
In-Reply-To: <20171201222330.18863-7-jeremy.linton@arm.com>
References: <20171201222330.18863-1-jeremy.linton@arm.com>
 <20171201222330.18863-7-jeremy.linton@arm.com>
Message-ID: <9009154.M66RGdQJXA@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 1, 2017 11:23:27 PM CET Jeremy Linton wrote:
> The PPTT can be used to determine the groupings of CPU's at
> given levels in the system. Lets add a few routines to the PPTT
> parsing code to return a unique id for each unique level in the
> processor hierarchy. This can then be matched to build
> thread/core/cluster/die/package/etc mappings for each processing
> element in the system.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Why can't this be folded into patch [2/9]?

Thanks,
Rafael
