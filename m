From: scott.branden@broadcom.com (Scott Branden)
Date: Mon, 27 Feb 2017 12:35:52 -0800
Subject: [Outreachy kernel] [PATCH] staging: bcm2835-audio: Fixed spacing
 around '&'
In-Reply-To: <alpine.DEB.2.20.1702270724430.2187@hadrien>
References: <1488131271-2908-1-git-send-email-narcisaanamaria12@gmail.com>
 <alpine.DEB.2.20.1702261901180.2056@hadrien>
 <1488134072.9188.3.camel@perches.com>
 <alpine.DEB.2.20.1702261956070.2056@hadrien>
 <1488137824.9188.7.camel@perches.com>
 <alpine.DEB.2.20.1702262038560.2056@hadrien>
 <1488146211.9188.10.camel@perches.com>
 <3ed05e4f-b00a-8a4b-f4f2-de23ff9b461e@broadcom.com>
 <alpine.DEB.2.20.1702270724430.2187@hadrien>
Message-ID: <954e0bc5-cd3c-c06f-dbfa-bed486b823c6@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julia,

On 17-02-26 10:25 PM, Julia Lawall wrote:
>
>
> On Sun, 26 Feb 2017, Scott Branden wrote:
>
>>
>>
>> On 17-02-26 01:56 PM, Joe Perches wrote:
>>> On Sun, 2017-02-26 at 20:40 +0100, Julia Lawall wrote:
>>>> On Sun, 26 Feb 2017, Joe Perches wrote:
>>>>> On Sun, 2017-02-26 at 19:59 +0100, Julia Lawall wrote:
>>>>>> On Sun, 26 Feb 2017, Joe Perches wrot
>>>>>>> Mailing lists _should_ be copied on patch submissions.
>>>>>> The idea of outreachy is that it should be a place for people to get
>>>>>> started without too much criticism from the outside.  Originally, only
>>>>>> the
>>>>>> outreachy mailing list received patches.  But staging maintainers were
>>>>>> confused to have their drivers receiving patches that they had not
>>>>>> seen.
>>>>>> So we expanded it to maintainers.
>>>>>
>>>>> That also doesn't make much sense as patches
>>>>> should not be applied that have not reached
>>>>> a mailing list for review.
>>>>>
>>>>> As long as initial outreachy patches are not
>>>>> applied and are just for internal review by
>>>>> any outside person but the outreachy list and
>>>>> are not be applied by maintainers, then perhaps
>>>>> it's best if neither maintainers nor lists are
>>>>> cc'd on the patches.
>>>>
>>>> The patches are applied by Greg.  Greg suggested the policy of adding
>>>> maintainers but not including mailing lists.  I'll let him consider
>>>> whether the policy should be changed.
>>>
>>> Well, I will comment on patches sent to the kernel list.
>>>
>>> I'm not subscribed to outreachy and I don't want to be
>>> subscribed to that list either.
>>>
>> I would prefer this outreachy work uses their own mailing list and reviews
>> their patches first.  Then once they have everything sorted out they send out
>> the patch series to the proper maintainers/mailing lists. That way we're not
>> spammed with all these emails of people as they are learning how to format and
>> send out proper patches.
>
> If you consider that you are getting too much outreachy mail at the
> moment, just let me know what subsystem you want me to add an exception
> for.

The emails seem to mostly be coming with bcm2835-audio.
>
> thanks,
> julia

Thanks,
  Scott
>
