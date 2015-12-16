From: andy.gross@linaro.org (Andy Gross)
Date: Wed, 16 Dec 2015 14:44:35 -0600
Subject: [1/2] ARM: dts: qcom: Remove size elements from pmic reg
 properties
In-Reply-To: <1448490457-9799-2-git-send-email-sboyd@codeaurora.org>
References: <1448490457-9799-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20151216204435.GA5951@Agamemnon.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 02:27:36PM -0800, Stephen Boyd wrote:
> The #size-cells for the pmics are 0, but we specify a size in the
> reg property so that MPP and GPIO modules can figure out how many
> pins there are. Now that we've done that by counting irqs, we can
> remove the size elements in the reg properties and be DT
> compliant.
> 
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Andy Gross <andy.gross@linaro.org>
