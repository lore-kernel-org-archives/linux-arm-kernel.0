From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 19 Jun 2015 20:43:24 +0200
Subject: [PATCH 1/3] ARM: pxa: add gpio-charger configuration on poodle
In-Reply-To: <CALT56yOwU2Lu2y1NDiD45KBm=FSm_V+m_0VbN1D5Gfcz7Xd7Pg@mail.gmail.com>
 (Dmitry Eremin-Solenikov's message of "Fri, 3 Apr 2015 22:23:41
 +0300")
References: <1427711971-8164-1-git-send-email-dbaryshkov@gmail.com>
 <874moxt42l.fsf@free.fr>
 <CALT56yOwU2Lu2y1NDiD45KBm=FSm_V+m_0VbN1D5Gfcz7Xd7Pg@mail.gmail.com>
Message-ID: <87lhffa69f.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> 2015-04-03 22:16 GMT+03:00 Robert Jarzmik <robert.jarzmik@free.fr>:
>> Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:
>>
>>> Add declration of gpio-charger device for Sharp SL-5600 poodle device.
>> Typo here ^.
>>
>> And I'd like in the commit message to know :
>>  - is it the main battery charger (I could look into the code, I know, but I'd
>>    like it to be in the commit message anyway) ?
>
> I'll add it to v2.
>
>>  - was it successfully tested on Sharp SL-5600 ?
>
> :)) I wouldn't dare to submit a code that wasn't tested on hw w/o
> special notice.

Hi Dmitry,

I'll drop that from my radar, I didn't see any update lately. Once the poodle
battery driver is accepted and once you provide an update on these patches, I'll
come back to these patches.

Cheers.

-- 
Robert
