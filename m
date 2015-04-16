From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 16 Apr 2015 10:23:08 -0500
Subject: [PATCH 1/2] Documentation: devicetree: root node serial-number
 property documentation
In-Reply-To: <CAL_JsqKdHQZL5Z6hKgquKihFykX0ZiCDQfeHOfOZWOh2NMg4Rw@mail.gmail.com>
References: <1427564371-26039-1-git-send-email-contact@paulk.fr>
 <f6f4f862c78fa626e7f94bde51eec5b1@agner.ch> <1429175421.2483.1.camel@collins>
 <CAL_JsqKdHQZL5Z6hKgquKihFykX0ZiCDQfeHOfOZWOh2NMg4Rw@mail.gmail.com>
Message-ID: <CFEF8F54-7A3E-482C-B295-6A6BC5D837C8@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On Apr 16, 2015, at 9:36 AM, Rob Herring <robherring2@gmail.com> wrote:
> 
> On Thu, Apr 16, 2015 at 4:10 AM, Paul Kocialkowski <contact@paulk.fr> wrote:
>> Le jeudi 16 avril 2015 ? 09:56 +0200, Stefan Agner a ?crit :
>>> On 2015-03-28 18:39, Paul Kocialkowski wrote:
>>>> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
>>> 
>>> I think this is a worthwhile standardization.
>>> 
>>> Acked-by: Stefan Agner <stefan@agner.ch>
>> 
>> Thanks! I should also add a commit message in v2 mentioning that this is
>> already used in open firmware and reported by lshw.
> 
> With that,
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
>> 
>>>> ---
>>>> Documentation/devicetree/booting-without-of.txt | 4 ++++
>>>> 1 file changed, 4 insertions(+)
>>>> 
>>>> diff --git a/Documentation/devicetree/booting-without-of.txt
>>>> b/Documentation/devicetree/booting-without-of.txt
>>>> index 7768518..8b055897 100644
>>>> --- a/Documentation/devicetree/booting-without-of.txt
>>>> +++ b/Documentation/devicetree/booting-without-of.txt
>>>> @@ -828,6 +828,10 @@ address which can extend beyond that limit.
>>>>   name may clash with standard defined ones, you prefix them with your
>>>>   vendor name and a comma.
>>>> 
>>>> +  Additional properties for the root node:
>>>> +
>>>> +    - serial-number : a string representing the board's serial number
>>>> +
>>>>   b) The /cpus node
>>>> 
>>>>   This node is the parent of all individual CPU nodes. It doesn't
>>> 
>> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

I feel like this is a little lite either in the doc or commit message.  Is the string completely arbitrary?  Is it meant to match labeling on a board or case?  Is this meant to be used by the kernel at all?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
