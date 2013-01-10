From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Jan 2013 11:49:20 +0100
Subject: [PATCH] gpio: vt8500: Export dedicated GPIO before multifunction
 pins.
In-Reply-To: <1356899374-9395-1-git-send-email-linux@prisktech.co.nz>
References: <1356899374-9395-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <CACRpkdagdO3_6DmKYaCwmx4Jju=E_uy86_QqdKLA3+VK7JNPjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 30, 2012 at 9:29 PM, Tony Prisk <linux@prisktech.co.nz> wrote:

> The vendor does not provide numbering for gpio pins. Vendor source
> exports dedicated gpio pins first, followed by multifunction pins.
> As this is what end users expect, this patch changes vt8500 and wm8505
> to do the same.
>
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>

So how many existing userspace applications does this patch
break? Has this system been widely deployed so a kernel
upgrade will cause problems for people?

But applied anyway, unless someone screams about it real
soon now. That seems to be the only way to get people to tell
us about their use cases.

Could you consider adding names to the exported GPIO pins
on the vt8500 series please? Then userspace can atleast
try to locate the right pin.

Yours,
Linus Walleij
