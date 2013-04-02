From: dianders@chromium.org (Doug Anderson)
Date: Tue, 2 Apr 2013 08:37:35 -0700
Subject: [PATCH v2] mmc: dwmmc: let device core setup the default pin
 configuration
In-Reply-To: <1364882999-31670-1-git-send-email-thomas.abraham@linaro.org>
References: <1364882999-31670-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CAD=FV=Xck5XW3LPmvkMfP=dfmnDH+kG4VYkRetW+SJ-bAz7SqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

On Mon, Apr 1, 2013 at 11:09 PM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> With device core now able to setup the default pin configuration,
> the pin configuration code based on the deprecated Samsung specific
> gpio bindings is removed.
>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Doug Anderson <dianders@chromium.org>

You missed Seungwon's other feedback.  Please change the title from
"mmc: dwmmc: let device core setup the default pin configuration" to
"mmc: dw_mmc: let device core setup the default pin configuration".
He requested that the tag have the underscore in it for consistency.

If you're resending, it also seems like it might be nice to rebase this atop:

0f6e73d mmc: dw_mmc: Add MSHC compatible for Exynos4412

...just to avoid the simple merge conflict when applying?

Otherwise everything here looks great...

-Doug
