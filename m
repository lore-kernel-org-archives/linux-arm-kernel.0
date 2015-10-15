From: sudeep.holla@arm.com (Sudeep Holla)
Date: Thu, 15 Oct 2015 16:21:11 +0100
Subject: [PATCH 1/2] ARM: dts: fix gpio-keys wakeup-source property
In-Reply-To: <CACRpkdaH+2+XGKNhK57tTOTRSvzL4duAZN1qZ+KgH2A4wf7zeQ@mail.gmail.com>
References: <1444743164-17735-1-git-send-email-sudeep.holla@arm.com>
 <CACRpkdaH+2+XGKNhK57tTOTRSvzL4duAZN1qZ+KgH2A4wf7zeQ@mail.gmail.com>
Message-ID: <561FC467.8090701@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 15/10/15 15:57, Linus Walleij wrote:
> On Tue, Oct 13, 2015 at 3:32 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>> The keyboard driver for GPIO buttons(gpio-keys) checks for one of the
>> two boolean properties to enable gpio buttons as wakeup source:
>> 1. "wakeup-source" or
>> 2. the legacy "gpio-key,wakeup"
>>
>> However juno, ste-snowball and emev2-kzm9d dts file have a undetected
>> "wakeup" property to indicate the wakeup source.
>>
>> This patch fixes it by making use of "wakeup-source" property.
>>
>> Cc: Simon Horman <horms@verge.net.au>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>
> OK nice,
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>

Can you pick this up as fix for v4.3 with Ack from Simon and Linus
Walleij ? I will repost 2/2 as a part of bigger cleanup for v4.4

-- 
Regards,
Sudeep
