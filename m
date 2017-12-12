From: jeremy.linton@arm.com (Jeremy Linton)
Date: Tue, 12 Dec 2017 10:13:08 -0600
Subject: [PATCH v5 6/9] ACPI/PPTT: Add topology parsing code
In-Reply-To: <9009154.M66RGdQJXA@aspire.rjw.lan>
References: <20171201222330.18863-1-jeremy.linton@arm.com>
 <20171201222330.18863-7-jeremy.linton@arm.com>
 <9009154.M66RGdQJXA@aspire.rjw.lan>
Message-ID: <fc12696c-15e1-cea4-42bf-db4b5daa45f2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

First, thanks for taking a look at this.

On 12/11/2017 07:12 PM, Rafael J. Wysocki wrote:
> On Friday, December 1, 2017 11:23:27 PM CET Jeremy Linton wrote:
>> The PPTT can be used to determine the groupings of CPU's at
>> given levels in the system. Lets add a few routines to the PPTT
>> parsing code to return a unique id for each unique level in the
>> processor hierarchy. This can then be matched to build
>> thread/core/cluster/die/package/etc mappings for each processing
>> element in the system.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> 
> Why can't this be folded into patch [2/9]?

It can, and I will be happy squash it.

It was requested that the topology portion of the parser be split out 
back in v3.

https://www.spinics.net/lists/linux-acpi/msg78487.html
