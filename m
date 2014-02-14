From: tony@atomide.com (Tony Lindgren)
Date: Fri, 14 Feb 2014 09:12:19 -0800
Subject: [PATCH] pinctrl: single: add low powr mode support
In-Reply-To: <CACRpkdaMDRKXgMjtbnV8hhhuKYbNzSG1U7LYnD5WEDaUE4z8pg@mail.gmail.com>
References: <1390893644-3458-1-git-send-email-chao.xie@marvell.com>
 <CACRpkdaMDRKXgMjtbnV8hhhuKYbNzSG1U7LYnD5WEDaUE4z8pg@mail.gmail.com>
Message-ID: <20140214171219.GC21592@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [140204 12:20]:
> On Tue, Jan 28, 2014 at 8:20 AM, Chao Xie <chao.xie@marvell.com> wrote:
> 
> > From: Chao Xie <chao.xie@marvell.com>
> >
> > For some silicons, the pin configuration register can control
> > the output of the pin when the pad including the pin enter
> > low power mode.
> > For example, the pin can be "Drive 1", "Drive 0", "Float" when
> > the pad including the pin enter low power mode.
> > It is very useful when you want to control the power leakeage
> > when the SOC enter low power mode, and can save more power for
> > the low power mode.
> >
> > Signed-off-by: Chao Xie <chao.xie@marvell.com>
> 
> Looks similar to the other pin config stuff, patch applied
> unless Tony protests.

Seems fine to me:

Acked-by: Tony Lindgren <tony@atomide.com>
