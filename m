From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 31 Aug 2016 20:34:48 +0300
Subject: [RESEND PATCH 1/2] ARM: dts: dra7: Fix clock data for
 gmac_gmii_ref_clk_div
In-Reply-To: <20160831143928.vxuaznyws2pipohu@atomide.com>
References: <20160830145801.10364-1-grygorii.strashko@ti.com>
 <20160830184158.xydy3ixy7c5b73le@atomide.com>
 <fd7850dd-b7a2-e6ef-508f-8406c3f2cea9@ti.com>
 <20160831143928.vxuaznyws2pipohu@atomide.com>
Message-ID: <232e8fb7-320f-3d64-b1f2-599d53d65291@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/08/16 17:39, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [160830 23:09]:
>> On 30/08/16 21:41, Tony Lindgren wrote:
>>> * Grygorii Strashko <grygorii.strashko@ti.com> [160830 07:58]:
>>>>
>>>> Originally this patch was posted (and acked) here
>>>> https://lkml.org/lkml/2016/4/27/272,
>>>> but it, unfortunatelly, has never been merged.
>>>> So re-send + minor subj change.
>>>
>>> OK yeah sorry about that. And thanks for the resend. If some patches
>>> have pending discussion as I tend to tag threads that have pending
>>> discussion as read and then forget them. And I miss patches in other
>>> ways too..
>>>
>>> Tero, care to take a look and ack?
>>
>> For both patches:
>>
>> Acked-by: Tero Kristo <t-kristo@ti.com>
>
> Thanks applying both into omap-for-v4.9/dt as the Ethernet works
> currently.
>
> Regards,
>
> Tony
>

Yea I think the ethernet clock rate happens to be the same in the 
existing setup, just the hierarchy is wrong. That is at least what I saw 
with quick testing.

-Tero
