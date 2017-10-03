From: robdclark@gmail.com (Rob Clark)
Date: Tue, 3 Oct 2017 14:54:33 -0400
Subject: [PATCH 2/2] arm64: dts: qcom: Rename SBC to DragonBoard 410c
In-Reply-To: <CAP71Wjy2gEn=sGz5kN++=TdZ4S1cmE-3fdw-5__tdtR-M9RDGQ@mail.gmail.com>
References: <20171003091155.7138-1-linus.walleij@linaro.org>
 <20171003091155.7138-2-linus.walleij@linaro.org>
 <b6b065c7-ad6b-d3da-704f-f139f12752d8@linaro.org>
 <CAF6AEGta20EGJOvLcFWVfUa3kpfq+Udyp1QRNzjY8P290A2tVg@mail.gmail.com>
 <CAP71Wjy2gEn=sGz5kN++=TdZ4S1cmE-3fdw-5__tdtR-M9RDGQ@mail.gmail.com>
Message-ID: <CAF6AEGvRB_SGQ_Xv33FiPZRyp+Wf29aG_Ex6rVk2Czov-Gjj9Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 3, 2017 at 1:49 PM, Nicolas Dechesne
<nicolas.dechesne@linaro.org> wrote:
> On Tue, Oct 3, 2017 at 6:37 PM, Rob Clark <robdclark@gmail.com> wrote:
>> On Tue, Oct 3, 2017 at 8:25 AM, Srinivas Kandagatla
>> <srinivas.kandagatla@linaro.org> wrote:
>>>
>>>
>>> On 03/10/17 10:11, Linus Walleij wrote:
>>>>
>>>> Naming the DragonBoard 410c "SBC" (I guess "single board computer")
>>>> is not very helpful for users looking for their device tree in
>>>> the kernel. Also the db820c is named properly.
>>>>
>>>> Rectify this, simply, do not change the compatible strings but name
>>>> the DTS files in a consistent manner.
>>>>
>>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> I did not like the sbc naming convention too, This was primarily done due to
>>> some legacy build tools + bootloaders which have used sbc compatible to
>>> identify boards from multiple dtb blobs. Now that we can append dtb to
>>> kernel with new LK, this should not be a issue anymore.
>>
>> maybe it would be an idea to update skales/dbttool first to look for
>> the new name, and then give people some time to upgrade, before
>> changing this in the kernel.  Otherwise I expect you'll cause some
>> confusion..
>
> iirc, skale is using the compatible name, not the filename.
>

ahh, yes, I think you are right.. u-boot is using a different filename.

So in this case, no issue to pick a saner name :-)

BR,
-R
