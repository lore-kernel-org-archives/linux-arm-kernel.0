From: vitalya@ti.com (Vitaly Andrianov)
Date: Wed, 14 Jan 2015 12:56:31 -0500
Subject: [Resend PATCH] ARM: mm: use phys_addr_t in ioremap_page functions
In-Reply-To: <20150114174407.GB12302@n2100.arm.linux.org.uk>
References: <1421257452-18834-1-git-send-email-vitalya@ti.com>
 <20150114174407.GB12302@n2100.arm.linux.org.uk>
Message-ID: <54B6ADCF.1090403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/14/2015 12:44 PM, Russell King - ARM Linux wrote:
> On Wed, Jan 14, 2015 at 12:44:12PM -0500, Vitaly Andrianov wrote:
>> On a 32 bit ARM architecture with LPAE extension physical addresses
>> cannot fit into unsigned long variable.
>>
>> This patch fixes the ioremap_page function.
>>
>> Signed-off-by: Vitaly Andrianov <vitalya@ti.com>
>> Acked-by: Murali Karicheri <m-karicheri2@ti.com>
>>
>> - Fixing the commit log and resending
>
> Still not happy.  Why do we even need this function which no one calls.
> Please delete it instead.
>

Thanks for the reply. I'll delete the function.
