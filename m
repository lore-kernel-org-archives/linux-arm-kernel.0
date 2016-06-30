From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 30 Jun 2016 20:52:53 +0300
Subject: [PATCH] ARM: dts: r8a7792: add SMP support
In-Reply-To: <20160630122718.GA24035@verge.net.au>
References: <14666252.G84Ipxe6EL@wasted.cogentembedded.com>
 <1627631.X1bJtVQHBF@wasted.cogentembedded.com>
 <7c23396f-f880-40ac-654d-cffc82df021e@cogentembedded.com>
 <20160630122718.GA24035@verge.net.au>
Message-ID: <c2c3584d-9a3b-bfd6-b795-6373e92c9dca@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2016 03:27 PM, Simon Horman wrote:

>>> Add the device tree nodes for the Advanced Power Management Unit (APMU)
>>> and the second Cortex-A15 CPU core.
>>> Use the "enable-method" prop  to point out that the APMU should be used
>>> for the SMP support.
>>>
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>
>>> ---
>>> This patch is against the 'renesas-devel-20160620-v4.7-rc4' tag of Simon
>>> Horman's 'renesas.git' repo.  It depends on Magnus'/Geert's SMP patchset...
>>
>>    simon, now that this patchset has been merged (for 4.8?), could you also
>> merge this patch?
>
> Sure, as this is for a new board I'll make a last minute exception and take
> this.

    Thank you! :-)

> I am trusting that cpu hotplug and suspend/resume have been adequately
> tested.

    Don't worry, all tests suggested by you have passed on this board.
Only the R8A7794/SILK board had trouble with hot-unplugging CPU0...

MBR, Sergei
