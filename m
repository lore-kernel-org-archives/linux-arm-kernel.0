From: l.luba@partner.samsung.com (Lukasz Luba)
Date: Tue, 9 Oct 2018 18:06:31 +0200
Subject: [PATCH] Doc: lockdep: add information about performance impact
In-Reply-To: <20181009154359.GB5728@hirez.programming.kicks-ass.net>
References: <CGME20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056@eucas1p2.samsung.com>
 <20181009153935eucas1p2dec146575ed5fefd4a0b2b6cb9bac056~b_ujkjRd31303013030eucas1p2C@eucas1p2.samsung.com>
 <20181009154359.GB5728@hirez.programming.kicks-ass.net>
Message-ID: <20181009160633eucas1p1a597c95256e64bf01de32366afdc59dd~b-GGjOUFN2705527055eucas1p1b@eucas1p1.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 10/09/2018 05:43 PM, Peter Zijlstra wrote:
> On Tue, Oct 09, 2018 at 05:39:27PM +0200, Lukasz Luba wrote:
>> This patch add some warning related to performance drop.
>> It should be mentioned that this is not for free
>> and the platfrom resources (cache, bus interconnect, etc.)
>> will be used more frequently.
> 
> To me this reads a bit like: water is wet.
> 
> Is this really needed?
> 
> 
Well, it would be good to know what is the performance drop
(10% or 20% or x3 times) when you are enabling different debug options.
I have spent some time analyzing these cache and bus strange behavior.
Now the developers would know that LOCKDEP might cause constant trashing 
of your cache in some use cases.

Regards,
Lukasz Luba
