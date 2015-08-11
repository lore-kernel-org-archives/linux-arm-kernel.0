From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 10 Aug 2015 23:59:32 -0700
Subject: [PATCH v8 03/13] clk: qcom: gdsc: Add support for Memory RET/OFF
In-Reply-To: <1438857474-20262-4-git-send-email-rnayak@codeaurora.org>
References: <1438857474-20262-1-git-send-email-rnayak@codeaurora.org>
 <1438857474-20262-4-git-send-email-rnayak@codeaurora.org>
Message-ID: <20150811065932.GE2839@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06, Rajendra Nayak wrote:
> Along with the GDSC power switch, there is additional control
> to either retain all memory (core and peripheral) within a given
> powerdomain or to turn them off while the GDSC is powered down.
> Add support for these by modelling a RET state where all
> memory is retained and an OFF state where all memory gets turned
> off.
> The controls provided are granular enough to be able to support
> various differnt levels of RET states, like a 'shallow RET' with all memory
> retained and a 'deep RET' with some memory retained while some others
> are lost. The current patch does not support this and considers
> just one RET state where all memory is retained. Futher work, if
> needed can support multiple different levels of RET state.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
