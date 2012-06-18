From: monstr@monstr.eu (Michal Simek)
Date: Mon, 18 Jun 2012 13:54:53 +0200
Subject: [RFC PATCH 5/8] AMP: smp: Extend number of IPIs
In-Reply-To: <20120618113548.GE12029@n2100.arm.linux.org.uk>
References: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
 <1340019011-18642-6-git-send-email-monstr@monstr.eu>
 <20120618113548.GE12029@n2100.arm.linux.org.uk>
Message-ID: <4FDF170D.3020107@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2012 01:35 PM, Russell King - ARM Linux wrote:
> On Mon, Jun 18, 2012 at 01:30:08PM +0200, Michal Simek wrote:
>> GIC supports up to 16 IPIs.
>>
>> Signed-off-by: Michal Simek<monstr@monstr.eu>
>>
>> ---
>> Please correct me if this code is also designed for different
>> interrupt controller which doesn't support 16 IPIs.
>
> This code is not specific to the GIC.  We use NR_IPI to indicate the
> number of IPIs that the kernel actually uses, not the number which the
> hardware provides.

ok.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
