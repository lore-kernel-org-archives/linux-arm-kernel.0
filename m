From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 7 Oct 2016 12:57:28 +0300
Subject: [PATCH v3 04/11] ARM: dts: r8a7743: initial SoC device tree
In-Reply-To: <20161007030932.GH13721@verge.net.au>
References: <2056698.ncAHq8vRQ3@wasted.cogentembedded.com>
 <2883940.Oo8sg10L7m@wasted.cogentembedded.com>
 <20161007030932.GH13721@verge.net.au>
Message-ID: <cd1391d1-d2b5-6315-ee15-0253019d9836@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/7/2016 6:09 AM, Simon Horman wrote:

>> The  initial R8A7743 SoC device tree including CPU cores, GIC, timer, SYSC,
>> CPG, and the required clock descriptions.
>>
>> Based on the original (and large) patch by Dmitry Shifrin
>> <dmitry.shifrin@cogentembedded.com>.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> I notice that this patch enables two CPUs. Have you tested SMP and:
> - CPU hotplug
> - Suspend to RAM

    No, not really. I'll remove CPU1. :-<

MBR, Sergei
