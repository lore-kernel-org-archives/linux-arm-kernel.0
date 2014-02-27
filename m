From: bjorn@kryo.se (Bjorn Andersson)
Date: Thu, 27 Feb 2014 08:00:10 -0800
Subject: [PATCH] devicetree: bindings: Make msm8974-pinctrl documentation
 match code
In-Reply-To: <1393441943-1689-1-git-send-email-sboyd@codeaurora.org>
References: <1393441943-1689-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CAJAp7Ojmx8FVR_JgWkyw7xKDBq55gT1-cmkveFSPVXB2Q8VYxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 26, 2014 at 11:12 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> The compatible string doesn't have an x in it. Fix it. Also
> remove the "qcom" prefix from pins and functions as this binding
> uses the generic pinctrl bindings for the pins and functions.
>
> Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks Stephen, this looks good. Sorry for missing this before.

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
