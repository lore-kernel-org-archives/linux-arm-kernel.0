From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Fri, 8 Sep 2017 17:30:09 -0700
Subject: [PATCH 04/14] ti_sci: Use %pS printk format for direct addresses
In-Reply-To: <20170908233042.wdxhpp2uv4rslmwg@kahuna>
References: <1504729681-3504-1-git-send-email-deller@gmx.de>
 <1504729681-3504-5-git-send-email-deller@gmx.de>
 <20170908233042.wdxhpp2uv4rslmwg@kahuna>
Message-ID: <956d4eab-e817-663d-197b-68a1a4ccb527@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/8/2017 4:30 PM, Nishanth Menon wrote:
> On 20:27-20170906, Helge Deller wrote:
>> Use the %pS printk format for printing symbols from direct addresses.
>> This is important for the ia64, ppc64 and parisc64 architectures, while on
>> other architectures there is no difference between %pS and %pF.
>> Fix it for consistency across the kernel.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Cc: Nishanth Menon <nm@ti.com>
>> Cc: Tero Kristo <t-kristo@ti.com>
>> Cc: Santosh Shilimkar <ssantosh@kernel.org>
>> Cc: linux-arm-kernel at lists.infradead.org
> 
> OK with me. Thanks for doing the patch.
> Acked-by: Nishanth Menon <nm@ti.com>
> 
> Santosh, Tero: maybe queue for an rc or later cycle, I think?
> 
Doesn't look a rc type fix so can wait for next one.
