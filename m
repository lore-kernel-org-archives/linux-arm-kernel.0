From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 14 Sep 2012 15:17:09 +0200
Subject: [PATCH v3 2/5] Documentation: add description of DT binding for
 the gpio-mvebu driver
In-Reply-To: <50524363.9070100@gmail.com>
References: <1347551658-24449-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1347551658-24449-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <50524026.20104@gmail.com> <20120913223059.2d0606b2@skate>
 <50524363.9070100@gmail.com>
Message-ID: <CACRpkdY3ePZLUJsX_X9QGyo6dCDmweUd5Lq7BYnQ4P0uGVj-uQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2012 at 10:34 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 09/13/2012 03:30 PM, Thomas Petazzoni wrote:
>> Dear Rob Herring,
>>
>> On Thu, 13 Sep 2012 15:20:54 -0500, Rob Herring wrote:
>>> On 09/13/2012 10:54 AM, Thomas Petazzoni wrote:
>>>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>>>> Cc: Grant Likely <grant.likely@secretlab.ca>
>>>> Cc: Linus Walleij <linus.walleij@stericsson.com>
>>>> Cc: Andrew Lunn <andrew@lunn.ch>
>>>> Cc: Jason Cooper <jason@lakedaemon.net>
>>>> Cc: Gregory Clement <gregory.clement@free-electrons.com>
>>>> ---
>>>
>>> Grant is pretty much offline right now.
>>
>> Yes, I know, but MAINTAINERS does not mention an alternate maintainer
>> for the GPIO subsystem. Who is the interim maintainer that will
>> ultimately have to ack/nack those patches?
>
> Linus W. is.

I stated Reviewed-by: on the GPIO patch, please merge it through the
Marvell tree (I guess that's the plan?)

Acked-by: on the rest FWIW, I'm no ARM SoC nor DT maintainer...

Yours,
Linus Walleij
