From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Jul 2014 11:09:51 +0200
Subject: [PATCH 3/3] ARM: msm: delete dangling debug UART code
In-Reply-To: <53BC179E.5050000@mm-sol.com>
References: <1404832303-14850-1-git-send-email-linus.walleij@linaro.org>
 <1404832303-14850-4-git-send-email-linus.walleij@linaro.org>
 <53BC179E.5050000@mm-sol.com>
Message-ID: <CACRpkda9DH6okoW17WoFndM3aKbxOWkUi8j4RFbeN45yUfJ8EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 8, 2014 at 6:09 PM, Georgi Djakov <gdjakov@mm-sol.com> wrote:
> On 07/08/2014 06:11 PM, Linus Walleij wrote:
>>
>> The config symbols CONFIG_MSM_DEBUG_UART1 and *UART3 are used
>> in the Trout board code, but these symbols are not defined anywhere
>> in the kernel so cleaning them out.
>>
>> This is not to be confused with CONFIG_DEBUG_MSM_UART1 and
>> CONFIG_DEBUG_MSM_UART2 which do exist.
>
> I have sent a similar patch: https://lkml.org/lkml/2014/5/26/406

OK I trashed this patch and applied your patch on top of the others instead.

I'll send a pull request for the sum total to ARM SoC soon-ish so this
doesn't fall to the floor.

Yours,
Linus Walleij
