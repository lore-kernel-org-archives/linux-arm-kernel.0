From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Jun 2015 10:20:06 +0200
Subject: [PATCH 3/3] ARM: dts: qcom: Replace gpio node with pinctrl node
In-Reply-To: <1433544745-325-4-git-send-email-bjorn.andersson@sonymobile.com>
References: <1433544745-325-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1433544745-325-4-git-send-email-bjorn.andersson@sonymobile.com>
Message-ID: <CACRpkdbO7J2rjdVNiPzOY_7o0j3QC9swJc_ni1Euz=coZc_+AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 6, 2015 at 12:52 AM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:

> Replace the standalone gpio driver with pinctrl-msm as we now have
> msm8660 support there.
>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

please funnel this through the ARM SoC tree.

Yours,
Linus Walleij
