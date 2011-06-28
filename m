From: s-anna@ti.com (Anna, Suman)
Date: Tue, 28 Jun 2011 14:46:33 -0500
Subject: [PATCH] omap: iommu: fix pte attributes for super section
In-Reply-To: <20110516.101157.344277473342871979.Hiroshi.DOYU@nokia.com>
References: <BANLkTinqPkftv7KmghCCBpEdULh0cNivHg@mail.gmail.com>
	<20110516.101157.344277473342871979.Hiroshi.DOYU@nokia.com>
Message-ID: <BANLkTinX=jCjh0yK=yS1hDifUtTwUVZvKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2011 at 2:11 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> wrote:
> From: "ext Anna, Suman" <s-anna@ti.com>
> Subject: [PATCH] omap: iommu: fix pte attributes for super section
> Date: Tue, 10 May 2011 10:25:17 -0700
>
>> From 5796d8d8a0ea5aee342b78ca6ead229971cff6c5 Mon Sep 17 00:00:00 2001
>> From: Suman Anna <s-anna@ti.com>
>> Date: Wed, 4 May 2011 17:45:37 -0500
>> Subject: [PATCH] omap: iommu: fix pte attributes for super section
>>
>> The PTE programming causes a 16MB entry to be interpreted
>> as a 4K entry because of the bitwise check, and therefore does
>> not set the attributes properly in the first-level descriptor
>> table. The bitwise check has been replaced appropriately.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
> Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

Tony,
Can this patch be queued up for the next rc, or is there any reason
for this to remain archived?
https://patchwork.kernel.org/patch/774932/

regards
Suman
