From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Wed, 05 Aug 2015 12:09:42 +0530
Subject: [PATCH 2/4] mfd: devicetree: bindings: Add clock subdevice node
 information
In-Reply-To: <CAL_Jsq+BuhbHgnYi6HfAJx986vtDuUJzbxBRgivX9pF1GhUSvQ@mail.gmail.com>
References: <1437476823-3358-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1437476823-3358-3-git-send-email-vaibhav.hiremath@linaro.org>
 <CAJKOXPeUJ-7je67q+9X1_FcFiczoQ6rqwMAoPLswapFEmqGGVg@mail.gmail.com>
 <55BAA17F.1070305@codeaurora.org>
 <CAL_Jsq+BuhbHgnYi6HfAJx986vtDuUJzbxBRgivX9pF1GhUSvQ@mail.gmail.com>
Message-ID: <55C1AFAE.3000500@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 31 July 2015 03:51 AM, Rob Herring wrote:
> On Thu, Jul 30, 2015 at 5:13 PM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> On 07/22/2015 10:08 PM, Krzysztof Kozlowski wrote:
>>>
>>> 2015-07-21 20:07 GMT+09:00 Vaibhav Hiremath <vaibhav.hiremath@linaro.org>:
>>>>
>>>> This patch updates the binding documentation for optional
>>>> clocks node and related information for buffered 32KHz clock.
>>>>
>>>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>>>> ---
>>>>    Documentation/devicetree/bindings/mfd/88pm800.txt | 28
>>>> +++++++++++++++++++++++
>>>>    1 file changed, 28 insertions(+)
>>>
>>> +Cc Stephen Boyd (clocks)
>>>
>>> We had a discussion whether clock bindings should be put in MFD
>>> bindings documentation or into separate file in bindings/clock but
>>> either way is fine for me:
>>
>>
>> No patch? :)
>>
>> I think Rob has been pushing for MFDs to document everything within one
>> file, but either way is fine from clk perspective.
>
> I don't recall that exactly. I did say that child bindings need to
> point back to the MFD binding. So this is fine with me:
>
> Acked-by: Rob Herring <robh@kernel.org>
>

Thanks Rob for the ack.

Can this be queued now (for next merge window)?

Thanks,
Vaibhav
