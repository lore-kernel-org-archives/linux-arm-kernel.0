From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 25 Jan 2018 08:48:59 +0100
Subject: [PATCH] ARM: dts: use a correct at24 fallback for
 at91-nattis-2-natte-2
In-Reply-To: <bd9bdd00-d7ce-e925-2d63-d0fbb86e07e9@axentia.se>
References: <20180124213412.4612-1-brgl@bgdev.pl>
 <bd9bdd00-d7ce-e925-2d63-d0fbb86e07e9@axentia.se>
Message-ID: <CAMRc=MfVpWKctrgovF2hAnxjiXP4TqzLqqyVCPrQiudg8DHwtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-01-24 23:12 GMT+01:00 Peter Rosin <peda@axentia.se>:
> Hi Bartosz,
>
> On 2018-01-24 22:34, Bartosz Golaszewski wrote:
>> We now require all at24 users to use the "atmel,<model>" fallback in
>> device tree for different manufacturers.
>
> I think my patch [3/4] from about a week ago was just a tiny bit
> better.
> https://lkml.org/lkml/2018/1/16/609
>
> Can we please pick that one directly instead of doing this partial
> step?
>
> Cheers,
> Peter

Hi Peter,

oh yes, sorry - I just grepped the entire code base from next for
invalid compatibles and didn't notice this was already fixed by you.
Let's drop it.

Thanks,
Bartosz
