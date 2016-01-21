From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 21 Jan 2016 15:46:57 +0100
Subject: [PATCH v2 0/3] Mediatek EFUSE Support
In-Reply-To: <56A0EBF0.2020703@linaro.org>
References: <1447930014-19579-1-git-send-email-andrew-ct.chen@mediatek.com>
 <CAGS+omA8XK6ksd7Ma8yAUbkSsHR6yQxjFrV+HGbd83UiH6T51g@mail.gmail.com>
 <566E94CA.1050700@linaro.org> <56A0A5E1.5050105@gmail.com>
 <56A0EBF0.2020703@linaro.org>
Message-ID: <56A0EF61.5080500@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 21/01/16 15:32, Srinivas Kandagatla wrote:
>
>
> On 21/01/16 09:33, Matthias Brugger wrote:
>>
>>
>> On 14/12/15 11:07, Srinivas Kandagatla wrote:
>>> Hi Andrew,
>>>
>>> On 14/12/15 04:27, Daniel Kurtz wrote:
>>>> Hi Srinivas,
>>>>
>>>> On Thu, Nov 19, 2015 at 6:46 PM, Andrew-CT Chen
>>>> <andrew-ct.chen@mediatek.com> wrote:
>>>>> This patch adds EFUSE support driver which is used by other drivers
>>>>> like thermal sensor and HDMI impedance.
>>>>>
>>>>> There are some efuses these fuses store things like calibration data,
>>>>> speed bins.. etc. Drivers like thermal sensor, HDMI impedance would
>>>>> read out this data for configuring the driver.
>>>>>
>>>>> Change in v2:
>>>>> 1. Rebase to 4.4-rc1
>>>>> 2. Modify the driver Makefile for more consistent with other drivers
>>>>> 3. Modify the compatible string to "mediatek,mt8173-efuse" and
>>>>> "mediatek,efuse"
>>>>
>>>> Do you still plan to queue this for v4.5?
>>>>
>>> Sorry guys, for the long delay in replying your pings, got busy with
>>> regular office stuff :-)
>>>
>>> Yes, It should go in v4.5, I did send request with my sign-off to Greg,
>>> he should take it via char-misc tree.
>>>
>>
>> I can't see this patches in the char-misc tree [1].
>> Can you please double check?
>
> Hi Matthias,
> Thanks for the patience. You should expect them to see after v4.5-rc1,
> that's when Greg said he would push the patches.
>

I'm a bit puzzled. Wouldn't that mean that they will get into mainline 
for v4.6.
I just want to know if I can take patch 3/3 through my v4.5-next branch 
(which eventually will be merged into v4.6-rc1) or if I have to wait.

Thanks,
Matthias
