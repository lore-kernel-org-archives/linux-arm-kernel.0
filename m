From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Wed, 06 May 2015 10:10:14 -0700
Subject: [PATCH 02/11] arm/mach-keystone: remove legacy __cpuinit sections
 that crept in
In-Reply-To: <20150506103704.GJ2067@n2100.arm.linux.org.uk>
References: <1430174880-27958-1-git-send-email-paul.gortmaker@windriver.com>
 <1430174880-27958-3-git-send-email-paul.gortmaker@windriver.com>
 <20150506103704.GJ2067@n2100.arm.linux.org.uk>
Message-ID: <554A4AF6.2060309@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/6/2015 3:37 AM, Russell King - ARM Linux wrote:
> On Mon, Apr 27, 2015 at 06:47:51PM -0400, Paul Gortmaker wrote:
>> We removed __cpuinit support (leaving no-op stubs) quite some time
>> ago.  However two crept back in as of commit 5eb3da7246a5b2dfac9f38
>> ("ARM: keystone: Switch over to coherent memory address space")
>>
>> Since we want to clobber the stubs too, get these removed now.
>>
>> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
>
> Santosh's email is now: Santosh Shilimkar <ssantosh@kernel.org>
>
Thanks Russell.


>> Cc: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> ---
>>   arch/arm/mach-keystone/platsmp.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
Paul, Change is fine by me. I can pick this up for 4.2

Regards,
Santosh
