From: andy.gross@linaro.org (Andy Gross)
Date: Sun, 10 Jan 2016 22:33:04 -0600
Subject: [PATCH] pinctrl: qcom: spmi-mpp: Skip pullup on ULT type MPPs
In-Reply-To: <1452284753-5450-1-git-send-email-sboyd@codeaurora.org>
References: <1452284753-5450-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20160111043304.GA4729@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 12:25:53PM -0800, Stephen Boyd wrote:
> The ULT type of MPPs don't have a pullup. Skip configuring the
> pullup on these types of pins.
> 
> Cc: Andy Gross <andy.gross@linaro.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Reviewed-by: Andy Gross <andy.gross@linaro.org>
