From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 2 Jan 2012 12:46:06 +0000
Subject: [PATCH 1/1] regulator/fixed: pass regulator_register of_node
In-Reply-To: <1325335876-15296-1-git-send-email-richard.zhao@linaro.org>
References: <1325225213-29655-1-git-send-email-richard.zhao@linaro.org>
 <1325335876-15296-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <20120102124605.GE4300@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 31, 2011 at 08:51:16PM +0800, Richard Zhao wrote:
> regulator_get needs of_node to find right regulator.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>

Applied, thanks, but please always use subject lines that match the
subsystem you're submitting against.
