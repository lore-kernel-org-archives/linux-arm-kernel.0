From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 20 Jul 2016 10:08:15 +0200
Subject: [PATCH] RFC: ARM: fix the uaccess crash on PB11MPCore
In-Reply-To: <5959782.fqYxkarPT3@wuerfel>
References: <1468256893-12811-1-git-send-email-linus.walleij@linaro.org>
 <CAA3gFWsZJ3BV+FncGHnHvXSDnxbg_2FnugtgVnanPmmaqKOJAQ@mail.gmail.com>
 <5959782.fqYxkarPT3@wuerfel>
Message-ID: <578F316F.2000706@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/12/2016 01:53 PM, Arnd Bergmann wrote:
> On Tuesday, July 12, 2016 1:27:11 PM CEST Neil Armstrong wrote:
>> 2016-07-11 19:08 GMT+02:00 Linus Walleij <linus.walleij@linaro.org>:
>>> The following patch was sketched by Russell in response to my
>>> crashes on the PB11MPCore after the patch for software-based
>>> priviledged no access support for ARMv8.1. See this thread:
>>> http://marc.info/?l=linux-arm-kernel&m=144051749807214&w=2
>>>
>>> I am unsure what is going on, I suspect everyone involved in
>>> the discussion is. I just want to repost this to get the
>>> discussion restarted, as I still have to apply this patch
>>> with every kernel iteration to get my PB11MPCore Realview
>>> running.
>>>
>>> I also know that Oxnas has actual, mass-deployed NAS (PogoPlug
>>> Pro variants) using PB11MPCore, and that they may or may not
>>> be seeing the same issue so I want their feedback on this: do
>>> you or do you not see this with mainline, or have you not even
>>> tested?
>>
>> Hi Linus,
>>
>> Actually the last off-tree support of the OX820 is on 4.4, and I do
>> not personally own a OX820 based device,
>> but I'm in he process of finding one to achieve upstream support along
>> the Ox810.
>>
> 
> The Aldi NAS boxes (NAS-212) are widely available on ebay in Germany,
> there is even a shop that sells both the Pogoplug and the Medion
> machine with Debian preinstalled: http://www.ebay.de/sch/it-shop-rm/m.html
> 
> If you need help getting one, you can send it to me and I forward
> it to your French address.
> 
> 	Arnd
> 

Arnd,

Thanks, I got a Pogoplug V3 and have access to the serial line, I will
forward port the 4.4 openwrt kernel to 4.7 ASAP and try to reproduce the bug
encountered by Linus.

Neil
