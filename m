From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 Mar 2017 09:11:00 +0100
Subject: [PATCH v3 7/8] clk: qcom: Add MSM8960/APQ8064 LPASS clock
 controller (LCC) driver
In-Reply-To: <CACRpkdaJpJm7z3JbX3a=hg2UhZLVe55HjjC+JcP+iZFBwu1CFQ@mail.gmail.com>
References: <1421719535-28398-1-git-send-email-sboyd@codeaurora.org>
 <1421719535-28398-8-git-send-email-sboyd@codeaurora.org>
 <CACRpkdaJpJm7z3JbX3a=hg2UhZLVe55HjjC+JcP+iZFBwu1CFQ@mail.gmail.com>
Message-ID: <CACRpkdZnqTxSVB0kcxEjj3N7w2b-gykE6o+X_2uj6iERrAUhFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 5:36 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> When looking at this and trying to adapt it to MSM8660/APQ8060
> like Neil did with MDM9615 I get pretty confused.

Nevermind, I think I have it figured out after staring at the code
and branch/divider/mux clocks a bit more. I'll send out my
MSM8660/APQ8060 LCC driver for review.

Yours,
Linus Walleij
