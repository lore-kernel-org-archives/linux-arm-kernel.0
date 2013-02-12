From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 12 Feb 2013 18:54:54 +0000
Subject: ARM big-endian on current kernels for linux-3.8
In-Reply-To: <20130212194942.1ec29bf4@skate>
References: <1360365467-25056-1-git-send-email-ben.dooks@codethink.co.uk>
 <20130212180858.289c3efa@skate> <511A7B14.1020107@codethink.co.uk>
 <20130212194942.1ec29bf4@skate>
Message-ID: <511A8FFE.702@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/02/13 18:49, Thomas Petazzoni wrote:
> Dear Ben Dooks,
>
> On Tue, 12 Feb 2013 17:25:40 +0000, Ben Dooks wrote:
>
>>>> Feedback and testing is welcome.
>>>
>>> I've tested your patch set on Armada XP. The kernel boots fine, but
>>> it fails to bring up the secondary CPUs:
>>
>> Yes, missed updating the coherency_ll.S patch.
>>
>> Attached new patch
>
> Thanks, I'll test this one tomorrow. Any pointer for a known-working
> armeb toolchain?

I've been building with gcc 4.6.3

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
