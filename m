From: monstr@monstr.eu (Michal Simek)
Date: Mon, 18 Jun 2012 13:54:35 +0200
Subject: [RFC PATCH 6/8] ARM: smp: Use generic API for ipi
In-Reply-To: <20120618113617.GF12029@n2100.arm.linux.org.uk>
References: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
 <1340019011-18642-7-git-send-email-monstr@monstr.eu>
 <20120618113617.GF12029@n2100.arm.linux.org.uk>
Message-ID: <4FDF16FB.6020300@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2012 01:36 PM, Russell King - ARM Linux wrote:
> On Mon, Jun 18, 2012 at 01:30:09PM +0200, Michal Simek wrote:
>> Support dynamic IPI allocation. It supports cases
>> where user wants to use IPI for communication among cpus
>> and setup own handler for it.
>>
>> New functions set_ipi_handler/clear_ipi_handler are used
>> for dynamic allocation.
>
> For what purpose?

Please look at my reaction in 4/8. It is the part of dynamic IPI allocation.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
