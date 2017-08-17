From: labbott@redhat.com (Laura Abbott)
Date: Thu, 17 Aug 2017 11:22:05 -0700
Subject: New assembler warnings with binutils 2.29
In-Reply-To: <20170814144509.ktozfiaa2c3p46r2@armadillo>
References: <d101c48b-c47b-be60-4b40-de4f845e4965@redhat.com>
 <20170811092213.mdmzqtm2lp6ltlxt@armageddon.cambridge.arm.com>
 <CAKv+Gu8EQq+azTjMNDpE=TzEd_6b-VdQqUYbCc1=qGuYTU4Srg@mail.gmail.com>
 <20170814085901.evwj3rrxo74wcgak@armageddon.cambridge.arm.com>
 <cab26e7e-a052-c78c-5ee7-fe11de1185bd@arm.com>
 <20170814103444.nl6tl3y6wppyk32h@armageddon.cambridge.arm.com>
 <20170814144509.ktozfiaa2c3p46r2@armadillo>
Message-ID: <89e1edd1-8aac-b3cb-ee4d-37751efa4878@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2017 07:45 AM, Ramana Radhakrishnan wrote:
> On Mon, Aug 14, 2017 at 11:34:45AM +0100, Catalin Marinas wrote:
>>>
>>> Any attempts to realias these to the correct meaning as per the AAPCS
>>> continues to work from my limited testing of a prototype patch so far.
>>
>> This would be great. Thanks Ramana!
> 
> I've submitted the patch upstream and would appreciate any testing of kernel
> builds to double check that this fixes the issue at hand.
> 
> https://sourceware.org/ml/binutils/2017-08/msg00160.html

I verified on a local build that this makes the warnings go away.

Thanks,
Laura

> 
> 
> Ramana
