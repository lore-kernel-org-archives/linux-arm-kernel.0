From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Fri, 27 Apr 2012 11:13:32 +0800
Subject: [PATCH 1/2] pinctrl: support gpio request deferred probing
In-Reply-To: <4F9A01B6.2050502@wwwdotorg.org>
References: <1335353894-22096-1-git-send-email-b29396@freescale.com>
 <CACRpkdadLsqpb=X+BmomyRywf=SrgGpbW2B=Myo3zTn_xMHJ2g@mail.gmail.com>
 <4F9A01B6.2050502@wwwdotorg.org>
Message-ID: <20120427031331.GD26070@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Fri, Apr 27, 2012 at 10:17:26AM +0800, Stephen Warren wrote:
> On 04/26/2012 03:36 PM, Linus Walleij wrote:
> > On Wed, Apr 25, 2012 at 1:38 PM, Dong Aisheng <b29396@freescale.com> wrote:
> > 
> >> From: Dong Aisheng <dong.aisheng@linaro.org>
> >>
> >> As pinctrl handles, it may be possible the pinctrl gpio ranges
> >> are still not got registered when user call pinctrl_gpio_request.
> >> Thus, add defer support for it too.
> >>
> >> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > Since nobody is saying anything and it looks reasonable,
> > I just applied this.
> 
> I didn't look at this, because V4 was sent without this patch, so I
> assumed it'd been dropped by Dong. Was I wrong?
> 
I thought this patch had no relationship with dummy state v4 patch and
it had no changes, so i did not resend it out with the v4 patch again.
It did not mean drop. Sorry for causing confusing.
Anyway thanks for your attention.

Regards
Dong Aisheng
