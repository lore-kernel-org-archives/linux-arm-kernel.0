From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 23 Aug 2016 08:40:39 +0800
Subject: [PATCH v3 1/5] drm/rockchip: sort registers define by chip's
 number
In-Reply-To: <CAOw6vbJdBwUdg5Qww-autFH=HvvaM-uac7-mN+Ja7PEDiPoPnw@mail.gmail.com>
References: <loom.20160602T084340-509@post.gmane.org>
 <1471454452-2151-1-git-send-email-seanpaul@chromium.org>
 <57B57AFE.2030706@rock-chips.com> <20160818091141.GZ6232@phenom.ffwll.local>
 <57B587C0.5050007@rock-chips.com>
 <CAOw6vbJdBwUdg5Qww-autFH=HvvaM-uac7-mN+Ja7PEDiPoPnw@mail.gmail.com>
Message-ID: <57BB9B87.2040406@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016?08?23? 04:30, Sean Paul wrote:
> On Thu, Aug 18, 2016 at 6:02 AM, Mark yao <mark.yao@rock-chips.com> wrote:
>> On 2016?08?18? 17:11, Daniel Vetter wrote:
>>> On Thu, Aug 18, 2016 at 05:08:14PM +0800, Mark yao wrote:
>>>>> Hi Sean
>>>>>
>>>>> Thanks for send v3 patch for rk3399 vop support.
>>>>>
>>>>> But sorry for that, I had changed my mind, those patches are deprecated,
>>>>> I have new rk3399 patch on my downstream kernel, I will upstream soon.
>>> Wut? Imo merge Sean's patch here, and then rebase your downstream patches
>>> on top of it. That you have a downstream tree which is out of sync with
>>> upstream shouldn't be a reason to stall upstream development.
>>> -Daniel
>>>
>> Yeah, Sorry for that.
>>
>> In fact, on my downstream kernel, also have those patches, my new rk3399
>> patches are based on them,
>> but the new rk3399 patches will cover the those patches,  Sean's patches is
>> old version.
>>
>> I just want to fast forward, don't want to send two version drivers to
>> upstream.
>> but if you and Dave feel ok for that, I have no problem:-) .
>>
>> merged Sean's patches and then apply new version patches.
>>
> Ok, so can I get a review/ack for these revised patches then?
> Something is better than nothing, and there's a bunch of stuff that
> depends on these changes.
>
> Sean
Yes, But I miss your [PATCH v3 0/5] and [PATCH v3 4/5]. do you mean the 
lost patches use v2 version?


>
>
>> Thanks.
>>
>> --
>> ?ark Yao
>>
>>
>
>


-- 
?ark Yao
