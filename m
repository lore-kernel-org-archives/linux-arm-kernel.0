From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Jan 2017 16:32:39 -0800
Subject: [PATCH 3/8] clk: renesas: cpg-mssr: Rename cpg_mssr_priv.mstp_lock
In-Reply-To: <1484921306-9967-4-git-send-email-geert+renesas@glider.be>
References: <1484921306-9967-1-git-send-email-geert+renesas@glider.be>
 <1484921306-9967-4-git-send-email-geert+renesas@glider.be>
Message-ID: <20170121003239.GU20800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20, Geert Uytterhoeven wrote:
> The spinlock is used to protect Read-Modify-Write register accesses,
> which won't be limited to SMSTPCR register accesses.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
