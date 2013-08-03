From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 3 Aug 2013 15:02:30 -0400
Subject: [PATCH v2 0/6] ARM: mm: Extend the runtime patch stub for PAE
 systems
In-Reply-To: <alpine.LFD.2.03.1308022150210.14472@syhkavp.arg>
References: <1375289086-5315-1-git-send-email-santosh.shilimkar@ti.com>
 <alpine.LFD.2.03.1308022150210.14472@syhkavp.arg>
Message-ID: <51FD53C6.1010904@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 August 2013 09:52 PM, Nicolas Pitre wrote:
> On Wed, 31 Jul 2013, Santosh Shilimkar wrote:
> 
>> This is version 2 of the series which addresses the comments/suggestions
>> we received on earlier version. The series trying to extend the existing
>> v2p runtime patching for LPAE machines which can have physical memory
>> beyond 4 GB. Keystone is one such ARM machine.
> 
> FYI: I never received patch 1/6.
>
Looks like since I converted the CC to ack for the 1/6, you didn't
received it.

 
>> In testing various modes(LPAE/non-LPAE, ARM/THMUB), we found an issue
>> with the patching code for THUMB2 build. So there is a patch added in
>> the series to address it. I was planning to squash it in the parent
>> 64 bit patch but thought of keeping it separate for ease of review.
>> We can squash it while merging the patches. 
> 
> Is this an issue with the current code before implementing 64 bit offset 
> patching?
> 
The issue was found with newly added code. I already see quite a bit of
discussion on those patches.

Regards,
Santosh
