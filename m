From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 18 Feb 2016 09:32:41 +0000
Subject: [PATCH] arm64: dts: msm8996: Add #power-domain-cells property
In-Reply-To: <1455787866-22223-1-git-send-email-rnayak@codeaurora.org>
References: <1455787866-22223-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <20160218093241.GA4931@hector.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 18, 2016 at 03:01:06PM +0530, Rajendra Nayak wrote:
> Add #power-domain-cells property for both the gcc and mmcc
> clock controller nodes as they both supports power domains (gdsc's)
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---
> Andy, the gdsc support patches for 8996 are pulled into clk-next.
> Can you please pull the dts changes in for 4.6?

Yes, I'll include it in the next pull.  Thanks!
