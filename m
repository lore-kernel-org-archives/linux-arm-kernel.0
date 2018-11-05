From: aisheng.dong@nxp.com (A.s. Dong)
Date: Mon, 5 Nov 2018 14:10:31 +0000
Subject: [PATCH V4 04/10] gpio: vf610: add optional clock support
In-Reply-To: <CACRpkdaO-cUd7wVksboUU0-qu20aBo370Rio=GkNH11U0CB4Jw@mail.gmail.com>
References: <1541149669-10857-1-git-send-email-aisheng.dong@nxp.com>
 <1541149669-10857-5-git-send-email-aisheng.dong@nxp.com>
 <CACRpkdaO-cUd7wVksboUU0-qu20aBo370Rio=GkNH11U0CB4Jw@mail.gmail.com>
Message-ID: <AM0PR04MB42117A904BCB651591B1075480CA0@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij at linaro.org]
> Sent: Friday, November 2, 2018 5:37 PM
[...]
> On Fri, Nov 2, 2018 at 10:12 AM A.s. Dong <aisheng.dong@nxp.com> wrote:
> 
> > Some SoCs need the gpio clock to be enabled before accessing HW
> > registers. This patch add the optional clock handling.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Stefan Agner <stefan@agner.ch>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: linux-gpio at vger.kernel.org
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> > v2->v3:
> >  * error checking updated according to Russell's suggestion:
> >    ptr == ERR_PTR(-EPROBE_DEFER)
> >  * clock independently checking
> 
> Please look at my feedback for v2 as well, sorry for the synchronization
> problems here... Didn't see this version until after replying.
> 

Thanks for the suggestion.
I just sent an updated version in reply to this thread.
Please help check if it's okay to you.

Regards
Dong Aisheng

> Yours,
> Linus Walleij
