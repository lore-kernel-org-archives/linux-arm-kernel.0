From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 19 Feb 2013 16:17:38 +0530
Subject: [RFC PATCH 06/18] davinci: replace V4L2_OUT_CAP_CUSTOM_TIMINGS
 by V4L2_OUT_CAP_DV_TIMINGS
In-Reply-To: <201302162033.53736.hverkuil@xs4all.nl>
References: <a9599acc7829c431d88b547de87c500968ccb86a.1361006882.git.hans.verkuil@cisco.com>
 <CA+V-a8tH8GLKz50i216S4TFkNjPpn1D1tNaRkuLfvDE_JO9N5g@mail.gmail.com>
 <511FDCBB.5010507@ti.com> <201302162033.53736.hverkuil@xs4all.nl>
Message-ID: <5123584A.9060006@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On 2/17/2013 1:03 AM, Hans Verkuil wrote:
> On Sat February 16 2013 20:23:39 Sekhar Nori wrote:
>> On 2/16/2013 6:28 PM, Prabhakar Lad wrote:
>>> Cc'ed Sekhar, DLOS, LAK.
>>>
>>> Sekhar Can you Ack this patch ? Or maybe you can take this patch through
>>> your tree ?
>>
>> I can take the patch, but I can only send for v3.10 since for v3.9 ARM
>> tree is only accepting bug fixes for already accepted code. If you wish
>> to take this through media tree for v3.9, feel free to add:
> 
> There is no hurry. If you can take this patch for 3.10, then that is fine
> by me. This patch series is unlikely to make it in 3.9 anyway, nor does it
> need to. Just let me know if you take it, then I can drop it from my patch
> series.

It appears that it will be simpler if you manage the entire series. I
have already acked this one, so please take it through the media tree.

Thanks,
Sekhar
