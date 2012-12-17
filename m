From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 17 Dec 2012 09:58:23 -0600
Subject: [PATCH 2/2] ARM: dts: OMAP2+: Add PMU nodes
In-Reply-To: <50CED4D3.9080106@ti.com>
References: <1355519930-3851-1-git-send-email-jon-hunter@ti.com>
 <1355519930-3851-3-git-send-email-jon-hunter@ti.com>
 <50CED4D3.9080106@ti.com>
Message-ID: <50CF411F.4060105@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12/17/2012 02:16 AM, Benoit Cousson wrote:
> Hi Jon,
> 
> On 12/14/2012 10:18 PM, Jon Hunter wrote:
>> Add PMU nodes for OMAP2, OMAP3 and OMAP4460 devices.
>>
>> Please note that the node for OMAP4460 has been placed in a separate
>> header file for OMAP4460, because the node is not compatible with
>> OMAP4430.
> 
> But where is the omap4430 node then?

I have left it out deliberately because OMAP4430 is not yet supported by
PMU as it is dependent on having a driver for the cross-trigger interface.

If you prefer to stick the node in the omap4.dtsi for now then that is
ok, but I wanted to make it clear that this is for omap4460.

Cheers
Jon
