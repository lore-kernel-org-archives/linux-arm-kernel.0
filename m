From: sboyd@kernel.org (Stephen Boyd)
Date: Sat, 07 Apr 2018 05:30:51 -0700
Subject: [PATCH 1/2] pinctrl: qcom: remove static globals to allow
 multiple TLMMs
In-Reply-To: <1521848700-22214-1-git-send-email-timur@codeaurora.org>
References: <1521848700-22214-1-git-send-email-timur@codeaurora.org>
Message-ID: <152310425175.180276.5998500344773462590@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Timur Tabi (2018-03-23 16:44:59)
> Two data structures are declared as static globals but are intended to
> be per-TLMM.  Move them into the msm_pinctrl structure and initialize
> them at runtime.
> 
> Signed-off-by: Timur Tabi <timur@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
