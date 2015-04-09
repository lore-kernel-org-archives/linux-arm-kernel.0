From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Thu, 09 Apr 2015 09:35:28 -0700
Subject: [PATCH 0/7] Fix Keystone 2 physical address switch
In-Reply-To: <20150409162139.GZ12732@n2100.arm.linux.org.uk>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
 <552563AB.8050308@oracle.com> <20150409162139.GZ12732@n2100.arm.linux.org.uk>
Message-ID: <5526AA50.9000407@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/9/2015 9:21 AM, Russell King - ARM Linux wrote:
> On Wed, Apr 08, 2015 at 10:21:47AM -0700, santosh shilimkar wrote:
>> Russell,
>>
>> On 4/8/2015 2:44 AM, Russell King - ARM Linux wrote:
>>> For some time, the Keystone 2 physical address switch has been
>>> tainting the kernel ever since we decided that it was not safe.
>>>
>>> This series re-works the address switch to be compliant architecturally.
>>>
>> Thanks a lot for doing it. Will have a look at the series.
>
> I think given where we are, it's already too late to get it into this
> merge window _unless_ Linus does -rc8 this weekend.  I don't classify
> this as a "fix" which would be mergable during the window or during
> -rc after, but more as a correctness update.
>
Right. We can get them in next one.

Regards,
Santosh
