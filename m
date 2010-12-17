From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Fri, 17 Dec 2010 15:14:59 +0900
Subject: [PATCH 14/17] ARM: S5PV310: Define I2S clocks
In-Reply-To: <AANLkTikkhZgnZs=q3=rs-=hYYE_5L4gtOEGV5MjunjkC@mail.gmail.com>
References: <1292561925-19586-1-git-send-email-jassisinghbrar@gmail.com>
	<1292562014-20036-1-git-send-email-jassisinghbrar@gmail.com>
	<AANLkTi=sh4if3FhU2-yUrFCUAtjWm4mDaMcf_JSTU8ia@mail.gmail.com>
	<AANLkTik0ob0bx0OBzG2Y2-mx-U=HUwuK1hzJwj8tRMZQ@mail.gmail.com>
	<AANLkTikkhZgnZs=q3=rs-=hYYE_5L4gtOEGV5MjunjkC@mail.gmail.com>
Message-ID: <AANLkTikdtqZMBjc16_fgZ_ruk2UB=0RaWE3u-=BTxuXT@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 17, 2010 at 3:02 PM, Kyungmin Park <kmpark@infradead.org> wrote:
> On Fri, Dec 17, 2010 at 2:51 PM, Jassi Brar <jassisinghbrar@gmail.com> wrote:
>> On Fri, Dec 17, 2010 at 2:44 PM, Kyungmin Park <kmpark@infradead.org> wrote:
>>>
>>> Don't you use the i2s instead of iis?
>>
>> The already present driver expects 'iis' so we have to call it so, atm.
>
> Then code clean is first?
Yes, the code needs cleaning, but i have more important tasks right now.

> Your logic same as you complained about code consistency.
Nopes.
If I simply change from 'iis' to 'i2s' here, audio would break.
My suggestion, the other day, to simply drop brackets from around
_constants_ couldn't break anything. And I didn't ask anybody to first
submit patch that removes all instances of brackets around constants.
