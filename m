From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 20 Aug 2015 22:04:13 +0300
Subject: [PATCH 0/2] Add VIN and ADV7180 device tree support for
 R8A7794/SILK board
In-Reply-To: <20150820185435.GE18990@verge.net.au>
References: <1750082.WpWf34HsI6@wasted.cogentembedded.com>
 <20150820185435.GE18990@verge.net.au>
Message-ID: <55D624AD.7060801@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2015 09:54 PM, Simon Horman wrote:

>>     Here's the set of 2 patches against Simon Horman's 'renesas.git' repo's
>> 'renesas-devel-20150819-v4.2-rc7' tag. Here we add the VIN and ADV7180
>> video decoder device tree support on the R8A7794/SILK board. The patchset
>> requires previously posted SILK SDHI1 support patch in order to apply and
>> R8A7794/SILK I2C1 support in order to apply and build.
>>
>> [1/2] ARM: shmobile: r8a7794: add VIN DT support
>> [2/2] ARM: shmobile: silk: add VIN0/ADV7180 DT support
>
> Thanks, I have queued these up for v4.4.

    Perhaps a bit too early: the PFC VIN patch hasn't been merged yet. Sorry 
for not specifying the PFC dependency...

MBR, Sergei
