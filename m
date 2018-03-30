From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Fri, 30 Mar 2018 13:07:14 +0200
Subject: [PATCH v3 0/8] ARM: davinci: complete the conversion to using the
 reset framework
In-Reply-To: <6166e140-b417-dd22-10cf-843db3958226@lechnology.com>
References: <20180327092031.11251-1-brgl@bgdev.pl>
 <6166e140-b417-dd22-10cf-843db3958226@lechnology.com>
Message-ID: <CAMRc=Me-+oDi7R-=sSbKU45EFDv04X2rswksLD2N1rnbYrZo2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-03-27 18:48 GMT+02:00 David Lechner <david@lechnology.com>:
> Wasn't there a v4 already? Is this really v5 instead of v3?
>

Yes there was and Philipp applied the v4 alright.

>
> On 03/27/2018 04:20 AM, Bartosz Golaszewski wrote:
>>
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> This series converts the only user of the handcoded, mach-specific reset
>> routines in the davinci platform to using the reset framework.
>>
>> Patches 1-3 add necessary lookups/DT-properties.
>
>
> Should I just squash the DT changes into my common-clock-v9 branch
> since those patches haven't been picked up yet anyway? That will be
> 2 fewer patches to keep track of.

I would personally prefer to keep the changesets thematically
separate. The clock series is big anyway already.

Thanks,
Bartosz
