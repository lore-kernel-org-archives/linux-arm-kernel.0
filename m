From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 16 Jun 2013 12:17:29 +0200
Subject: [PATCH] pinctrl: document the pinctrl PM states
In-Reply-To: <51BB3A2C.608@wwwdotorg.org>
References: <1370980749-15383-1-git-send-email-linus.walleij@stericsson.com>
 <51BA1FE7.4000900@wwwdotorg.org>
 <CACRpkdZV7R3MgbuvEMhs24YYv2hK8Kt9Kjmv_cpRQQ1NYviDQg@mail.gmail.com>
 <51BB3A2C.608@wwwdotorg.org>
Message-ID: <CACRpkdbmv4abXiYZEpN7BsV+H1aafm+tQV4r8bFWYVKtFDQZMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 5:43 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 06/13/2013 02:34 PM, Linus Walleij wrote:
>> On Thu, Jun 13, 2013 at 9:39 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>>> On 06/11/2013 01:59 PM, Linus Walleij wrote:
>>>> From: Linus Walleij <linus.walleij@linaro.org>
>>>>
>>>> This document snippet tries to be helpful and define the pin
>>>> PM states and helpers, and how they should be used to create
>>>> some kind of common ontology around this.
>>>
>>> Oops. I haven't been keeping up well. I propose we hold off on this
>>> patch for a short while until the other thread on this topic is finalized.
>>
>> Isn't it better if I split it?
>>
>> Most of this doc is about the default/sleep/idle states and
>> how that relates to runtime PM, and that seems to be
>> uncontroversial.
>
> I would tend to prefer sorting out the issue fully, then documenting it
> once. This avoids churn.

OK I've pulled out this patch for now.

Yours,
Linus Walleij
