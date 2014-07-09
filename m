From: bjorn@kryo.se (Bjorn Andersson)
Date: Wed, 9 Jul 2014 15:16:24 -0700
Subject: [PATCH v3] pinctrl: msm: move all qualcomm drivers to subdir
In-Reply-To: <1404910216-2170-1-git-send-email-linus.walleij@linaro.org>
References: <1404910216-2170-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <CAJAp7Oi-UH4SUHNw_gHtm=P8EYG3+BsA=hPAsZZWjfG5KCMJeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 9, 2014 at 5:50 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> We have four Qualcomm-related pin control drivers, and now there
> are drivers coming in for the PMICs on these systems, so let's
> create a qcom subdirectory to hold all the Qualcomm stuff.
>
> Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Cc: Ivan T. Ivanov <iivanov@mm-sol.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Nice initiative.

Acked-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
