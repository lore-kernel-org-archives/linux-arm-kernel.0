From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 1 Jul 2016 16:32:39 -0500
Subject: [PATCH] soc: qcom: smem: Silence probe defer error
In-Reply-To: <20160701211859.23471-1-sboyd@codeaurora.org>
References: <20160701211859.23471-1-sboyd@codeaurora.org>
Message-ID: <20160701213239.GB7295@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 01, 2016 at 02:18:59PM -0700, Stephen Boyd wrote:
> If we fail to get the hwspinlock due to probe defer, we shouldn't
> print an error message. Just be silent in this case.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Looks good to me.  This has needed to be fixed for a while.  Thanks!


Andy
