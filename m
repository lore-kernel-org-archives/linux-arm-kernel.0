From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Jul 2014 14:00:55 +0200
Subject: No uart output on my snowball board
In-Reply-To: <20140710223021.6e9c857f@gandalf.local.home>
References: <20140710223021.6e9c857f@gandalf.local.home>
Message-ID: <CACRpkdZM5NECaPbFC1aGH2zD4T_8g9TYRy1HkbDVAQvjJs5E5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 11, 2014 at 4:30 AM, Steven Rostedt <rostedt@goodmis.org> wrote:

> commit a0998b8321eb5f53ef51924f5ab6c69237ac1025
> Author: Lee Jones <lee.jones@linaro.org>
> Date:   Thu Aug 22 16:18:56 2013 +0100
>
>     ARM: ux500: Remove UART support when booting without Device Tree
>
>     It's time to remove all ATAG support from ux500 and rely solely on
>     Device Tree booting. This patch is part of that endeavour.
>
>     Signed-off-by: Lee Jones <lee.jones@linaro.org>
>     Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I hate that I didn't spot the speling mistake in the subject,
its ATAG support we're removing, not UART :-)

Anyway, I think you got enough hints on how we do this
with appended devicetrees instead, Lee's snippet should
work or check out this page that I also posted to your
G+ post:
http://www.df.lth.se/~triad/krad/ux00/

Yours,
Linus Walleij
