From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Thu, 17 Nov 2016 07:42:35 +0530
Subject: [PATCH 08/16] ARM: vexpress: use generic API for enabling SCU
In-Reply-To: <c6cb4dbd-847e-832a-894b-bf8718248538@arm.com>
References: <1479099731-28108-1-git-send-email-pankaj.dubey@samsung.com>
 <1479099731-28108-9-git-send-email-pankaj.dubey@samsung.com>
 <CGME20161116143434epcas1p1ac5f9f241a1433e59513ee36c3bfe846@epcas1p1.samsung.com>
 <c6cb4dbd-847e-832a-894b-bf8718248538@arm.com>
Message-ID: <a8d15df2-ab8c-880e-9c38-61a573ca9b6f@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On Wednesday 16 November 2016 08:04 PM, Sudeep Holla wrote:
> 
> 
> On 14/11/16 05:02, Pankaj Dubey wrote:
>> Now as we have of_scu_enable which takes care of mapping
>> scu base from DT, lets use it.
>>
>> CC: Liviu Dudau <liviu.dudau@arm.com>
>> CC: Sudeep Holla <sudeep.holla@arm.com>
> 
> I assume you will take this series through a single tree. Also I assume
> you may make changes around a9 SCU. I will try to test if I can get my
> setup back working. But if this patch is not changed, then
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Thanks for review and Ack.

Yes, plan is to take this series through a single tree.
As there are few comments for other platforms and common scu file, I
will address them and submit v2 of this series soon. But I can see there
won't be any changes for vexpress platform patch in v2, so I will
include your Ack.

Thanks,
Pankaj Dubey
