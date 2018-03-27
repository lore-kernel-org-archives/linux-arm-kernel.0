From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Mar 2018 15:33:02 +0200
Subject: [PATCH 1/2] pinctrl: qcom: remove static globals to allow
 multiple TLMMs
In-Reply-To: <1521848700-22214-1-git-send-email-timur@codeaurora.org>
References: <1521848700-22214-1-git-send-email-timur@codeaurora.org>
Message-ID: <CACRpkdZ=z7EncPykPwK+m-_qM3J2PokmkcoKsRqao_X1qx7CSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 24, 2018 at 12:44 AM, Timur Tabi <timur@codeaurora.org> wrote:

> Two data structures are declared as static globals but are intended to
> be per-TLMM.  Move them into the msm_pinctrl structure and initialize
> them at runtime.
>
> Signed-off-by: Timur Tabi <timur@codeaurora.org>

Waiting for a review from Stephen or Bjorn on these two
patches.

Yours,
Linus Walleij
