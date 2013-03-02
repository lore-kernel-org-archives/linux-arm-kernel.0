From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 2 Mar 2013 11:46:13 +0530
Subject: [PATCH 09/15] ARM: OMAP4+: PM: Restore CPU power state to ON
 with clockdomain force wakeup method
In-Reply-To: <20130301215315.GA23856@kahuna>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
 <1362139864-9233-10-git-send-email-santosh.shilimkar@ti.com>
 <20130301215315.GA23856@kahuna>
Message-ID: <5131992D.2080006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 02 March 2013 03:23 AM, Nishanth Menon wrote:
> On 17:40-20130301, Santosh Shilimkar wrote:
>> While waking up CPU from off state using clock domain force wakeup, restore
>> the CPU power state to ON state before putting CPU clock domain under
>> hardware control. Otherwise CPU wakeup might fail. The change is recommended\
> the trailing \ was unintentional I suppose.
Yes.. 
>> for all OMAP4+ devices though the PRCM weakness was observed on OMAP5
>> devices first.
>>
>> So update the code accordingly.
>>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>> ---
[..]
> Otherwise:
> Acked-by: Nishanth Menon <nm@ti.com>
> 
Thanks
