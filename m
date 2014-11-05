From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 5 Nov 2014 10:23:34 +0900
Subject: [PATCH 0/2] ARM: shmobile: r8a7791: Correct number of CPU cores
In-Reply-To: <20141105003656.GC2017@verge.net.au>
References: <1414139589-13605-1-git-send-email-horms+renesas@verge.net.au>
 <20141105003656.GC2017@verge.net.au>
Message-ID: <CANqRtoT4FezTLYr0RC9QzwwHSTSbMA4aJC70K3J42_O22BAgXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, Nov 5, 2014 at 9:36 AM, Simon Horman <horms@verge.net.au> wrote:
> On Fri, Oct 24, 2014 at 05:33:07PM +0900, Simon Horman wrote:
>> Hi,
>>
>> this short series separates AMPU resource data as it is not
>> common accross R-Car gen2 SoCs: only the r8a7790 (H1) has the resouces
>> described. It then corrects the resource data for the r8a7791,
>> the only other SoC currently present in mainline that uses this data.
>>
>> Based on the renesas-next-20141024-v3.18-rc1 tag of my renesas tree.
>>
>> Hisashi Nakamura (2):
>>   ARM: shmobile: Separate APMU resource data into CPU dependant part
>>   ARM: shmobile: r8a7791: Correct number of CPU cores
>
> I have queued up this series.

Thanks. I didn't say anything so I should probably be silent, but in
the future it would make sense to fold in the fix into the original
patch to void merging broken stuff.

Cheers,

/ magnus
