From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 15 Jun 2010 18:49:00 +1200
Subject: [PATCH 0/5] SPEAr3xx: Unify build of SPEAr3xx platforms
In-Reply-To: <4C171067.1060102@st.com>
References: <1275717955-14545-1-git-send-email-ryan@bluewatersys.com>
	<4C171067.1060102@st.com>
Message-ID: <4C17225C.8030201@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viresh KUMAR wrote:
> On 6/5/2010 11:35 AM, Ryan Mallon wrote:
>> Rework the SPEAr3xx code to allow all three SPEAr3xx platforms to be
>> built into a single kernel.
>>
>> I do not have access to any SPEAr3xx hardware, so the patch series is
>> build tested only.
>>
>> Ryan Mallon (5):
>>   SPEAr3xx: Make local structres static
>>   SPEAR3xx: Rename register/irq defines to remove naming conflicts
>>   SPEAr3xx: Rework pmx_dev code to remove conflicts
>>   SPEAr3xx: Rework KConfig to allow all boards to be compiled in
>>   SPEAr3xx: Replace defconfigs with single unfied defconfig
> 
> Ryan,
> 
> Patches looks fine to me, but i need to test them before i Ack them.
> Please give me some time to do that, currently i am very busy in some other
> activities.
> 
> viresh.

Thanks, let me know if you need help with the code at all.

~Ryan
