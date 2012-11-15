From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 15 Nov 2012 09:53:35 +0100
Subject: [PATCHv2] i2c: omap: Move the remove constraint
In-Reply-To: <CAM=Q2cvE2=c_L5YhkeXscx=2EfZp5MGtdnp6KowhwUQx_j1Muw@mail.gmail.com>
References: <1352964883-9846-1-git-send-email-shubhrajyoti@ti.com>
 <CAORVsuVuOLKpcx085VWiPRaD4syS-5F4+s+eKXGN8PPRRiTg2g@mail.gmail.com>
 <CAM=Q2cvE2=c_L5YhkeXscx=2EfZp5MGtdnp6KowhwUQx_j1Muw@mail.gmail.com>
Message-ID: <CAORVsuUE0pdmVyWO5-7TGZn=-XDib1jqbEVRK7Bmhj9bx_HGQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 9:51 AM, Shubhrajyoti Datta
<omaplinuxkernel@gmail.com> wrote:
> On Thu, Nov 15, 2012 at 1:46 PM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
>> Hi Shubhrajyoti,
>>
>> On Thu, Nov 15, 2012 at 8:34 AM, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
>>> Currently we just queue the transfer and release the
>>> qos constraints, however we donot wait for the transfer
>> Typo: donot
> Just fixed and resent.
>
>>
>>> to complete to release the constraint. Move the remove
>>> constraint after the bus busy as we are sure that the
>>> transfers are completed by then.
>>>
>>> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
>> Looks good!
>> Acked-by: Jean Pihet <j-pihet@ti.com>
>
> Thanks for review.

Thanks!

Regards,
Jean

>
>>
>> Regards,
>> Jean
>>
