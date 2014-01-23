From: bjorn@kryo.se (Bjorn Andersson)
Date: Thu, 23 Jan 2014 12:22:12 -0800
Subject: [PATCH v3 1/2] i2c: qup: Add device tree bindings information
In-Reply-To: <174308F1-FFD2-4CB3-AEA2-C423F90FB133@codeaurora.org>
References: <1389999819-10648-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1389999819-10648-2-git-send-email-bjorn.andersson@sonymobile.com>
 <CAL_JsqJBEu8iLzE8-dXniZFytr6cQsprBYiYnJeXS2-80iy1Mw@mail.gmail.com>
 <174308F1-FFD2-4CB3-AEA2-C423F90FB133@codeaurora.org>
Message-ID: <CAJAp7OhvFdC2OR_YO5Gh6x1q8TPWEDY58d-BQ5jw=B=31i5V2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 23, 2014 at 11:11 AM, Matthew Locke <mlocke@codeaurora.org> wrote:
> Rob,
>
> On Jan 20, 2014, at 8:10 AM, Rob Herring wrote:
>
>> On Fri, Jan 17, 2014 at 5:03 PM, Bjorn Andersson
[...]
>>> +Required properties:
>>> + - compatible: Should be "qcom,i2c-qup".
>>
>> Seems a bit generic. All versions of the IP are exactly the same?
>> "qcom,<chip>-i2c-qup" would be better.
>
> The QUP IP block is the same across chips.  Its possible there could be different versions of the IP block but its pretty stable now.

I have not been able to find any differences in this block between
8960 and 8074 and I have successfully tested the driver on both
platforms.

So the reason for making it more specific would be to handle any
future crazyness. Not sure what to do about this though, I have never
heard about the version numbers Stephen gave us and I can't find them
in the documentation available to us, so I wouldn't know which of the
two to select...

Regards,
Bjorn
