From: saeed@marvell.com (Saeed Bishara)
Date: Mon, 16 May 2011 14:15:35 +0300
Subject: [PATCH 1/2] ARM: remove unneeded check of the
	cache_is_vipt_nonaliasing()
In-Reply-To: <1305544307.19230.8.camel@e102109-lin.cambridge.arm.com>
References: <1305225183-15521-1-git-send-email-saeed@marvell.com>
	<BANLkTim=dmHg_vyfYN6m73z6SQXiVzM7vg@mail.gmail.com>
	<BANLkTikUphZ4azqK50YBZa4uTyU4EystLA@mail.gmail.com>
	<BANLkTikWJzdYOrk4=gte8zOHDVioGAOhhg@mail.gmail.com>
	<BANLkTimFst-+LEuN9cDpAtRiF4aDOipAKA@mail.gmail.com>
	<20110516110032.GO30539@n2100.arm.linux.org.uk>
	<FCBE654890C0334289D0AD3AF4EF009F01162C9200E2@IL-MB01.marvell.com>
	<1305544307.19230.8.camel@e102109-lin.cambridge.arm.com>
Message-ID: <FCBE654890C0334289D0AD3AF4EF009F01162C9200EB@IL-MB01.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 

>-----Original Message-----
>From: Catalin Marinas [mailto:catalin.marinas at arm.com] 
>Sent: Monday, May 16, 2011 2:12 PM
>To: Saeed Bishara
>Cc: Russell King - ARM Linux; saeed bishara; 
>linux-arm-kernel at lists.infradead.org
>Subject: RE: [PATCH 1/2] ARM: remove unneeded check of the 
>cache_is_vipt_nonaliasing()
>
>On Mon, 2011-05-16 at 12:10 +0100, Saeed Bishara wrote:
>> commit 1ae2a4434959b5c6b234fa5f6eb5ad9a8e0fba0c
>> Author: Saeed Bishara <saeed@marvell.com>
>> Date:   Thu May 12 19:45:25 2011 +0300
>> 
>>     ARM: remove unneeded check of the cache_is_vipt_nonaliasing()
>> 
>>     when cache_is_vipt_nonaliasing(), we always have 
>pte_exec() true at
>>     the end of this function, so no need for the additional check.
>> 
>>     Acked-by: Catalin Marinas <catalin.marinas@arm.com>
>
>Please add your Signed-off-by as well.
Sure.
Russle, I submitted the previous patch to patch system, how should change its status to discarded then upload new one?

saeed
