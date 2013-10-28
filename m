From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 28 Oct 2013 15:59:34 +0000
Subject: [PULL REQ] Big Endian initial patch series
In-Reply-To: <20131028085328.GI16735@n2100.arm.linux.org.uk>
References: <20131018205405.GA28835@codethink.co.uk>
 <20131019170954.GC25076@mudshark.cambridge.arm.com>
 <5262E2C7.7000106@codethink.co.uk>
 <20131028004736.GG16735@n2100.arm.linux.org.uk>
 <20131028084455.GA20218@mudshark.cambridge.arm.com>
 <20131028085328.GI16735@n2100.arm.linux.org.uk>
Message-ID: <526E89E6.8010202@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/10/13 08:53, Russell King - ARM Linux wrote:

>> +#ifdef __ARMEB_
>> +#define LOW_OFFSET     0x4
>> +#define HIGH_OFFSET    0x0
>> +#else
>> +#define LOW_OFFSET     0x0
>> +#define HIGH_OFFSET    0x4
>> +#endif
>>
>> (spot the missing underscore).
>
> Yep, well spotted.
>
> Well, we have some time to get this all fixed, so I'm going to drop
> Ben's tree.  I think we need to first commit a patch to fix the error
> in Santosh's patch

Ok, shall I look at re-basing to -rc6?

I have a bug report with a change to the SCU reading for the SMP
fix-up case which could do with fixing, so I could add this and send
another pull request (complete with description this time).

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
