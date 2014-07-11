From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Jul 2014 14:58:13 +0100
Subject: No uart output on my snowball board
In-Reply-To: <CACRpkdZM5NECaPbFC1aGH2zD4T_8g9TYRy1HkbDVAQvjJs5E5w@mail.gmail.com>
References: <20140710223021.6e9c857f@gandalf.local.home>
 <CACRpkdZM5NECaPbFC1aGH2zD4T_8g9TYRy1HkbDVAQvjJs5E5w@mail.gmail.com>
Message-ID: <20140711135813.GD2954@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 Jul 2014, Linus Walleij wrote:
> On Fri, Jul 11, 2014 at 4:30 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > commit a0998b8321eb5f53ef51924f5ab6c69237ac1025
> > Author: Lee Jones <lee.jones@linaro.org>
> > Date:   Thu Aug 22 16:18:56 2013 +0100
> >
> >     ARM: ux500: Remove UART support when booting without Device Tree
> >
> >     It's time to remove all ATAG support from ux500 and rely solely on
> >     Device Tree booting. This patch is part of that endeavour.
> >
> >     Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >     Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I hate that I didn't spot the speling mistake in the subject,
> its ATAG support we're removing, not UART :-)

Now you're going coo-coo. :)

The subject line is fine.  Take a look at the patch.

> Anyway, I think you got enough hints on how we do this
> with appended devicetrees instead, Lee's snippet should
> work or check out this page that I also posted to your
> G+ post:
> http://www.df.lth.se/~triad/krad/ux00/

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
