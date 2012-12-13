From: julien.delacou@stericsson.com (Julien DELACOU)
Date: Thu, 13 Dec 2012 09:18:48 +0100
Subject: [PATCH 1/2] pinctrl: add sleep mode management for hogs
In-Reply-To: <CACRpkdak+f8Nnyns+jdGsxrzD1839-kdOqySChD9aDG+7KMU7Q@mail.gmail.com>
References: <1355234393-17368-1-git-send-email-linus.walleij@stericsson.com>
 <50C7A194.7070102@wwwdotorg.org>
 <CACRpkdak+f8Nnyns+jdGsxrzD1839-kdOqySChD9aDG+7KMU7Q@mail.gmail.com>
Message-ID: <50C98F68.4020107@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2012 08:31 PM, Linus Walleij wrote:
> On Tue, Dec 11, 2012 at 10:11 PM, Stephen Warren<swarren@wwwdotorg.org>  wrote:
>
>> Since I assume those function are only supposed to be used by pinctrl
>> drivers themselves, should the prototypes go into drivers/pinctrl/core.h
>> or similar, rather than something in include/linux/pinctrl?
> Good point, Julien can you fix this?
Sure, I will.
>
> Hm, maybe pinctrl_force_sleep()/default() isn't such a good name,
> maybe it should be pinctrl_hogs_sleep()/pinctrl_hogs_default() intead?
>
>> Oh, and don't you need EXPORT_SYMBOL in case the pinctrl driver is a module?
> True.
I will do it too.
>
>> Aside from that,
>>
>> Reviewed-by: Stephen Warren<swarren@nvidia.com>
> Thanks.
>
> Yours,
> Linus Walleij
Thanks a lot.

Regards,
Julien
