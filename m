From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 01 Dec 2015 09:38:16 +0000
Subject: [PATCH v12 05/16] arm64: Add back cpu_reset routines
In-Reply-To: <1448913810.31214.61.camel@infradead.org>
References: <cover.1448403503.git.geoff@infradead.org>	
 <3279584774ba40f088b79f4df864d69a5b57b516.1448403503.git.geoff@infradead.org>	
 <56586679.8060403@arm.com> <1448913810.31214.61.camel@infradead.org>
Message-ID: <565D6A88.10408@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/11/15 20:03, Geoff Levand wrote:

Hi Geoff,

>>> +.align 5
>>
>> Why is this .align directive required?
> 
> In the original proc.S file, this was to align the cpu_reset
> routine.  It has been there since the initial commit of the
> proc.S.  I don't think this alignment is needed, but maybe
> there is some reason it is there that I am not aware of?

None that I can think of, so just drop it - we'll find out pretty
quickly if there was an actual requirement.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
