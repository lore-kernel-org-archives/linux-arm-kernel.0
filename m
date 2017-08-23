From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Aug 2017 10:32:08 +0200
Subject: [PATCH 1/3] gliolib: request the gpio before querying its
 direction
In-Reply-To: <103341c8-6cc5-3d3f-eef7-28b9f31cdc71@codeaurora.org>
References: <1501179565-26466-1-git-send-email-timur@codeaurora.org>
 <1501179565-26466-2-git-send-email-timur@codeaurora.org>
 <CACRpkdYPBd4ZvuXo__LRQezTQD3u=3r2WO+2dTzBanLL1zX72w@mail.gmail.com>
 <103341c8-6cc5-3d3f-eef7-28b9f31cdc71@codeaurora.org>
Message-ID: <CACRpkdZv0NjXfwm_-TSoY=QFeP64V-ZoKvmLXk3qkV49fq1UtQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 21, 2017 at 11:23 PM, Timur Tabi <timur@codeaurora.org> wrote:
> On 07/31/2017 08:35 AM, Linus Walleij wrote:
>>>
>>> Before querying a GPIO to determine its direction, the GPIO should be
>>> formally requested.  This allows the GPIO driver to block access to
>>> unavailable GPIOs, which makes it easier for some drivers to support
>>> sparse GPIO maps.
>>>
>>> Signed-off-by: Timur Tabi<timur@codeaurora.org>
>>
>> This makes all kind of semantic change, so patch applied.
>
> Have you push it to git.kernel.org?  I don't see it.

It's right there on the "devel" branch from the GPIO git tree.
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/log/?h=devel

Yours,
Linus Walleij
