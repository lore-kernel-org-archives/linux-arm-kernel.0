From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 18 Feb 2016 21:48:43 +0100
Subject: [PATCH 07/11] Documentation/DT: add Versatile display bindings
In-Reply-To: <56C43936.2060808@ti.com>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-8-git-send-email-linus.walleij@linaro.org>
 <56C43936.2060808@ti.com>
Message-ID: <CACRpkdbGqbjEwHcspcRW0_889YO0RpVTef2mhVdP_9vJHMD8gQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 10:11 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:

>> +Required properties:
>> +- compatible: should be "epson,l2f50113t00"
>> +
>> +This binding is compatible with the panel-dpi binding, which is specified
>> +in panel-dpi.txt in this directory.
>
> Do we really want to add new binding doc files for all panels, even if
> they just point to a more generic binding? We may end up with quite a
> lot of these, each only saying "look at the panel-dpi.txt".

That's sort of what I'm asking too. But there was some other
file doing exactly this :(

What do you say about just putting a list of compatible panels
directly into panel-dpi.txt?

Yours,
Linus Walleij
