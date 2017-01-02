From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 2 Jan 2017 10:42:12 -0600
Subject: [PATCH v2] ARM: dts: qcom: apq8064: Add missing scm clock
In-Reply-To: <20161229120611.7948-1-bjorn.andersson@linaro.org>
References: <20161229120611.7948-1-bjorn.andersson@linaro.org>
Message-ID: <20170102164212.GD17770@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2016 at 04:06:11AM -0800, Bjorn Andersson wrote:
> As per the device tree binding the apq8064 scm node requires the core
> clock to be specified, so add this.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Thanks.  This works quite nicely.  I'll send a fixes pull for this.

Andy
