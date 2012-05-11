From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 May 2012 10:33:08 +0200
Subject: [PATCH 12/12] ARM: ux500: switch MSP to using pinctrl for pins
In-Reply-To: <4FAAD95D.9010108@wwwdotorg.org>
References: <1336470347-23886-1-git-send-email-linus.walleij@stericsson.com>
 <4FAAD95D.9010108@wwwdotorg.org>
Message-ID: <CACRpkdYRv5w=P4zTLZiG69rMN5Rt-yah4EdgWfg03oD7Tcvzqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 9, 2012 at 10:53 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 05/08/2012 03:45 AM, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> The MSP platform data callbacks use the old custom callbacks to
>> set the state of the pins, switch over to using pinctrl.
>
> Aside from the comments I've already made, I guess you can consider the
> whole series:
>
> Acked-by: Stephen Warren <swarren@wwwdotorg.org>

Thanks Stephen! Pushing this through ARM SoC.

Yours,
Linus Walleij
