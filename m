From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Fri, 9 May 2014 14:04:25 -0700
Subject: [PATCH] RFT: pinctrl: msm: switch to using generic GPIO irqchip
 helpers
In-Reply-To: <CACRpkdb7ctDocntcPG_E4b_an2G8VNd+ei0N+Uk_7XtsFssiEA@mail.gmail.com>
References: <1398794794-28920-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdb7ctDocntcPG_E4b_an2G8VNd+ei0N+Uk_7XtsFssiEA@mail.gmail.com>
Message-ID: <20140509210424.GA25733@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 09 May 01:33 PDT 2014, Linus Walleij wrote:

> On Tue, Apr 29, 2014 at 8:06 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> > This switches the Qualcomm MSM pin control driver over to using
> > the generic GPIO irqchip helpers.
> >
> > Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Cc: Josh Cartwright <joshc@codeaurora.org>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Anyone up for testing this patch?
> 
> Bj?rn? Andy?

Sorry for the delay.

This looks good and seems to work fine on my 8974 board.

Acked-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
