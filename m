From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 23 Feb 2016 10:08:05 +0100
Subject: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
In-Reply-To: <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
Message-ID: <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 4, 2016 at 3:04 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> This moves the versatile CLCD configuration to the device tree by:

As this Schr?dinger's cat approach seems controversial, as well
as the alternative to manipulate the DT in memory at run-time,
I will respin the series without the full Versatile support, adding
plug-in for the other ARM boards and and half-baked support
for the Versatile supporting just VGA (like the other reference
designs from ARM).

The pluggable displays prove yet again to be a problem to the
world, sigh.

I will think of a better solution, if any, for this for v4.6, but will
put forward something that handles the Nomadik and all the
other ARM reference designs for now.

Yours,
Linus Walleij
