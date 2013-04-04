From: tgih.jun@samsung.com (Seungwon Jeon)
Date: Thu, 04 Apr 2013 14:47:02 +0900
Subject: [PATCH v2] mmc: dwmmc: let device core setup the default pin
 configuration
In-Reply-To: <CAD=FV=Xck5XW3LPmvkMfP=dfmnDH+kG4VYkRetW+SJ-bAz7SqQ@mail.gmail.com>
References: <1364882999-31670-1-git-send-email-thomas.abraham@linaro.org>
 <CAD=FV=Xck5XW3LPmvkMfP=dfmnDH+kG4VYkRetW+SJ-bAz7SqQ@mail.gmail.com>
Message-ID: <004201ce30f7$d4beea20$7e3cbe60$%jun@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 03, 2013, Doug Anderson wrote:
> Thomas,
> 
> On Mon, Apr 1, 2013 at 11:09 PM, Thomas Abraham
> <thomas.abraham@linaro.org> wrote:
> > With device core now able to setup the default pin configuration,
> > the pin configuration code based on the deprecated Samsung specific
> > gpio bindings is removed.
> >
> > Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Reviewed-by: Doug Anderson <dianders@chromium.org>
> > Tested-by: Doug Anderson <dianders@chromium.org>
> 
> You missed Seungwon's other feedback.  Please change the title from
> "mmc: dwmmc: let device core setup the default pin configuration" to
> "mmc: dw_mmc: let device core setup the default pin configuration".
> He requested that the tag have the underscore in it for consistency.
> 
> If you're resending, it also seems like it might be nice to rebase this atop:
> 
> 0f6e73d mmc: dw_mmc: Add MSHC compatible for Exynos4412
> 
> ...just to avoid the simple merge conflict when applying?
> 
> Otherwise everything here looks great...
> 
> -Doug
Thomas,
It's a conflict to merge. Please do rebase the patch.

Thanks,
Seungwon Jeon
