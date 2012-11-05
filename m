From: b-cousson@ti.com (Benoit Cousson)
Date: Mon, 5 Nov 2012 12:03:44 +0100
Subject: [PATCH V2 0/3] ARM: dts: omap5: EMIF and LPDDR2 device tree data
In-Reply-To: <50979A14.1050805@ti.com>
References: <1349959669-16366-1-git-send-email-lokeshvutla@ti.com>
 <50975581.7010508@ti.com> <50979A14.1050805@ti.com>
Message-ID: <50979D10.1070406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/05/2012 11:51 AM, Benoit Cousson wrote:
> Hi Lokesh,
> 
> On 11/05/2012 06:58 AM, Lokesh Vutla wrote:
>> Hi,
>> On Thursday 11 October 2012 06:17 PM, Lokesh Vutla wrote:
>>> This patch series adds Device tree data for the EMIF
>>> sdram controllers in OMAP5 and LPDDR2 memory devices
>>> in OMAP5-evm board.
>>>
>>> Testing:
>>> - Boot tested on OMAP5430 evm.
>>> - Built EMIF as a module.
>>>
>>> Changes from v1:
>>> * Created a seperate dtsi file for Samsung LPDDR2 memory device
>>>    used in OMAP5-evm.
>>> * Passing reg and interrupt fields from dt for EMIF1 and EMIF2.
>> Gentle ping on this series.
> 
> Sorry, I missed it. It might be too late for 3.8, since Tony wanted us
> to push before -rc4. I'll pull the series anyway just in case.
> 
> I have a least one comment.

Could you just rebase on top of the for_3.8 branch, fix the minor
comments and repost ASAP.

Thanks,
Benoit
