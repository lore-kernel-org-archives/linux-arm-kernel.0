From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Jun 2013 05:03:41 -0700
Subject: [PATCH 01/11] pinctrl: single: adopt pinctrl sleep mode management
In-Reply-To: <CACRpkdZjvW6M1Q+K3OD1x_Jkz91AofdOdBThyJLGJ+Wx-BDTNw@mail.gmail.com>
References: <1369995191-20855-1-git-send-email-gururaja.hebbar@ti.com>
 <1369995191-20855-2-git-send-email-gururaja.hebbar@ti.com>
 <CACRpkdZjvW6M1Q+K3OD1x_Jkz91AofdOdBThyJLGJ+Wx-BDTNw@mail.gmail.com>
Message-ID: <20130617120340.GE10305@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [130617 04:38]:
> On Fri, May 31, 2013 at 12:13 PM, Hebbar Gururaja
> <gururaja.hebbar@ti.com> wrote:
> 
> > Make pinctrl-single able to handle suspend/resume events and change
> > hogged pins states accordingly.
> >
> > Signed-off-by: Hebbar Gururaja <gururaja.hebbar@ti.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> 
> Noone said anything about this patch, but it looks very straight-forward
> to me and seems sound so I have applied it.
> 
> If Tony or Haojian has strong feelings about it I will dequeue it.

I don't like the hogged pins at all as they prevent me from unloading
pinctrl-single.. But the patch seems fine to me:

Acked-by: Tony Lindgren <tony@atomide.com>
