From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 1 Jun 2016 17:00:27 +0300
Subject: [PATCH 07/13] ARM: dts: r8a7792: initial SoC device tree
In-Reply-To: <20160601005751.GG20527@verge.net.au>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
 <2539026.OyU5nvpxa6@wasted.cogentembedded.com>
 <20160601005751.GG20527@verge.net.au>
Message-ID: <83904aa1-edde-0968-3f0b-0d2962d377f5@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/2016 03:57 AM, Simon Horman wrote:

>> The initial R8A7792 SoC device tree including 2 CPU cores, GIC, timer, SYSC,
>> and the required  clock descriptions.
>>
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> This is rather large for an initial DTSI. Did you give any consideration
> to splitting it up: e.g. only providing what is needed to get to a serial
> console?

    You mean dropping the majority of clocks, right?

> With regards to SMP. Have you checked to make sure CPU hotplug works
> on all CPUs? And that the system behaves sanely on suspend/resume.
> If it is not possible to verify this at this stage then I would recommend
> only enabling one CPU at this stage.

    No, the SMP support isn't ready yet.
    And I'll have to enable SMP on R8A7794 as well...

MBR, Sergei
