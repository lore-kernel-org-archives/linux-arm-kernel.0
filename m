From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 24 Jan 2017 10:11:05 +0900
Subject: [PATCH] ARM: Ignore compressed kernel build products
In-Reply-To: <d65b22f0-5eb1-2dd4-cd89-d6351ffe53f2@gmail.com>
References: <20161208185449.7196-1-f.fainelli@gmail.com>
 <d65b22f0-5eb1-2dd4-cd89-d6351ffe53f2@gmail.com>
Message-ID: <CAK7LNAQDrq+WTqr4YCLkYLA260HamASVbUbV5PZmZrYLh2farg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-01-24 9:51 GMT+09:00 Florian Fainelli <f.fainelli@gmail.com>:
> On 12/08/2016 10:54 AM, Florian Fainelli wrote:
>> When we select a kernel compression scheme, we will end-up with e.g:
>> piggy.xzkern under arch/arm/boot/compressed/, let's ignore these files.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>
> I took the liberty to submit this patch as 8645/1 since it is a trivial
> change. Thanks!


Are you reverting 53f67545c21c756d7959fb86af30899c4b43141c ?
Why do you need this?


-- 
Best Regards
Masahiro Yamada
