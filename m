From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 21 Apr 2017 19:14:37 -0700
Subject: [PATCH 1/2] clk: mediatek: add mt2701 ethernet reset
In-Reply-To: <1485175707-58528-2-git-send-email-john@phrozen.org>
References: <1485175707-58528-1-git-send-email-john@phrozen.org>
 <1485175707-58528-2-git-send-email-john@phrozen.org>
Message-ID: <20170422021437.GF7065@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23, John Crispin wrote:
> The ethernet clock core has a reset register that is currently not exposed
> to the user. Fix this by adding the missing registration code.
> 
> Signed-off-by: John Crispin <john@phrozen.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
