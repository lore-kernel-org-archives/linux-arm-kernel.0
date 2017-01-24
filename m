From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 23 Jan 2017 17:13:04 -0800
Subject: [PATCH] ARM: Ignore compressed kernel build products
In-Reply-To: <CAK7LNAQDrq+WTqr4YCLkYLA260HamASVbUbV5PZmZrYLh2farg@mail.gmail.com>
References: <20161208185449.7196-1-f.fainelli@gmail.com>
 <d65b22f0-5eb1-2dd4-cd89-d6351ffe53f2@gmail.com>
 <CAK7LNAQDrq+WTqr4YCLkYLA260HamASVbUbV5PZmZrYLh2farg@mail.gmail.com>
Message-ID: <12e5d825-7471-ff95-c88c-1c2d1d3c5f76@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/2017 05:11 PM, Masahiro Yamada wrote:
> 2017-01-24 9:51 GMT+09:00 Florian Fainelli <f.fainelli@gmail.com>:
>> On 12/08/2016 10:54 AM, Florian Fainelli wrote:
>>> When we select a kernel compression scheme, we will end-up with e.g:
>>> piggy.xzkern under arch/arm/boot/compressed/, let's ignore these files.
>>>
>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>
>> I took the liberty to submit this patch as 8645/1 since it is a trivial
>> change. Thanks!
> 
> 
> Are you reverting 53f67545c21c756d7959fb86af30899c4b43141c ?
> Why do you need this?

OK, missed that one. Seems like I was switching between different
branches of in the same source tree, so they had a different version of
.gitignore as well.

Russell please drop this from your patch tracker, sorry about that.

Thanks
-- 
Florian
