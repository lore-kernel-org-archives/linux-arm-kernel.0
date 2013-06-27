From: balajitk@ti.com (Balaji T K)
Date: Thu, 27 Jun 2013 21:56:50 +0530
Subject: [PATCH 0/5] AM33xx: MMC resources from DT without HWMOD data
In-Reply-To: <CAD=GYpa9LQ1fV6=O9B65sJURVAigsgXCPLWav8cHXTuGQXPc9A@mail.gmail.com>
References: <1372209808-6532-1-git-send-email-joelagnel@ti.com>
 <CAD=GYpbdVVrh-tiqOcbHi3mkWRJUBdx0EsEZEFVVbgFgcCWgsw@mail.gmail.com>
 <51CC2A1E.2040003@ti.com>
 <CAD=GYpa9LQ1fV6=O9B65sJURVAigsgXCPLWav8cHXTuGQXPc9A@mail.gmail.com>
Message-ID: <51CC67CA.2070805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 June 2013 07:56 PM, Joel A Fernandes wrote:
> Hi Benoit,
>
> On Thu, Jun 27, 2013 at 7:03 AM, Benoit Cousson <b-cousson@ti.com> wrote:
>> Hi Joel,
>>
>> On 06/26/2013 05:28 AM, Joel A Fernandes wrote:
>>> On Tue, Jun 25, 2013 at 8:23 PM, Joel A Fernandes <joelagnel@ti.com> wrote:
>>>> From: Joel A Fernandes <agnel.joel@gmail.com>
>>>>
>>>> This series is fixes to get MMC working on AM33XX without HWMOD data.
>>>> On removal of HWMOD data, interrupt and register properties need to be provided
>>>> for the driver to function correctly.
>>>
>>> Please don't pull patches authored by me in this series. I have posted
>>> them with my wrong email address by mistake. I will correct my email
>>> during the next repost, after a round of review. Matt's patches in the
>>> series are still good though.
>>
>> In that case, please repost these in two series to avoid pulling the DTS
>> files in the MMC tree.
>
> The series has been replaced with the single patch:
> "[PATCH v2] ARM: dts: add AM33XX MMC support"
> http://marc.info/?l=linux-omap&m=137230403815943&w=2
>
> Some patches were squashed and others dropped in the series resulting
> in the single
> patch above. This patch should be good to apply
Hi Joel,

Before pushing mmc dts support for am335x, Can you please let me
know if below 2 patches [1] are merged/accepted,
IIRC these patches are needed for MMC to work properly.

I suggest to hold the dts patch until slave_sg_limit gets merged
otherwise it will cause regression in am335x mmc.

[PATCH v4 1/3] dmaengine: add dma_get_slave_sg_limits()
[PATCH v4 2/3] dma: edma: add device_slave_sg_limits() support

[1]
https://groups.google.com/forum/#!topic/linux.kernel/khTTcPtQpag

>
> Thanks,
>
> -Joel
>
