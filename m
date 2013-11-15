From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 14 Nov 2013 19:15:44 -0500
Subject: [PATCH 6/6] ARM: kvm: TMP: Commit the hyp page tables to main
 memory
In-Reply-To: <20131115001115.GC20516@lvm>
References: <y> <1384457866-16135-1-git-send-email-santosh.shilimkar@ti.com>
 <1384457866-16135-7-git-send-email-santosh.shilimkar@ti.com>
 <20131115001115.GC20516@lvm>
Message-ID: <528567B0.1020308@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 November 2013 07:11 PM, Christoffer Dall wrote:
> On Thu, Nov 14, 2013 at 02:37:46PM -0500, Santosh Shilimkar wrote:
>> This is a temporary hack which I have to use to avoid a weired crash while
>> starting the guest OS on Keystsone. They are random crashesh while the
>> guest os userspace starts. Additional data point is, it seen only with first
>> guest OS lanch. Subsequest guest OS starts normal.
>>     
> 
> what crashes?  The guest?  Where, how?
>
When guest userspace starts. The crashes are random but always after the
guest init process have started.
 
> 
>> I still don't know why this is needed but it helps to get around the issue
>> and hence including the patch in the series for the discussion
> 
> It may not be needed but is just hiding the issue.  I'm afraid you're
> going to have to dig a little more into this.
> 
I replied already on this. Further testing, I found the issue
even with this patch applied. I need to dig bit more as you said.

Regards,
Santosh
