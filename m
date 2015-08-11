From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 10 Aug 2015 23:59:37 -0700
Subject: [PATCH v8 04/13] clk: qcom: gdsc: Add support for ON only state
In-Reply-To: <1438857474-20262-5-git-send-email-rnayak@codeaurora.org>
References: <1438857474-20262-1-git-send-email-rnayak@codeaurora.org>
 <1438857474-20262-5-git-send-email-rnayak@codeaurora.org>
Message-ID: <20150811065937.GF2839@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06, Rajendra Nayak wrote:
> Certain devices can have GDSCs' which support ON as the only state.
> They can't be power collapsed to either hit RET or OFF.
> The clients drivers for these GDSCs' however would expect the state
> of the core to be reset following a GDSC disable and re-enable.
> To do this assert/deassert reset lines every time the client
> driver would request the GDSC to be powered on/off instead.
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
