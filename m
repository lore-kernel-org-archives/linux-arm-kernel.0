From: dnelson@redhat.com (Dean Nelson)
Date: Fri, 9 Feb 2018 06:52:01 -0600
Subject: net: thunder: change q_len's type to handle max ring size
In-Reply-To: <CA+sq2Cdkycu2BXOfywMTksUNOJcUS6-NStOXk=WHSZ9sT7np4Q@mail.gmail.com>
References: <151811766130.10712.18293368656209944798.email-sent-by-dnelson@aqua>
 <20180208.153453.774785043965984772.davem@davemloft.net>
 <41824374-cdea-a3ef-0109-20565dbba43e@redhat.com>
 <CA+sq2Cdkycu2BXOfywMTksUNOJcUS6-NStOXk=WHSZ9sT7np4Q@mail.gmail.com>
Message-ID: <cc5f8e9e-fb36-e785-3430-8ae9faea316a@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2018 10:29 PM, Sunil Kovvuri wrote:
> On Fri, Feb 9, 2018 at 3:27 AM, Dean Nelson <dnelson@redhat.com> wrote:
>> On 02/08/2018 02:34 PM, David Miller wrote:
>>>
>>> From: Dean Nelson <dnelson@redhat.com>
>>> Date:
>>>
>>>> The Cavium thunder nicvf driver supports rx/tx rings of up to 65536
>>>> entries per.
  ...
>>>
>>> Another way to solve this could have been to encode that length
>>> as "length - 1"
>>
>>
>> True. I had pondered that, but felt that since changing q_len's type
>> didn't add any length to the structure and that it was less impactful
>> from a number-of-lines of code changed perspective, I'd opt for this
>> route.
>>
>> Cavium, if you'd prefer this goes the route that Dave just mentioned,
>> please let me know and I can make a new patch against what's been
>> applied?
> 
> Thanks for fixing this and i think the current patch is fine.

You're welcome. And thanks for responding. So I'll leave things as they
are.
