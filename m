From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 31 Aug 2015 21:59:45 -0700
Subject: [PATCH 2/3] soc: qcom: smd: Use __iowrite32_copy() instead of
 open-coding it
In-Reply-To: <1441071594-15941-3-git-send-email-sboyd@codeaurora.org>
References: <1441071594-15941-1-git-send-email-sboyd@codeaurora.org>
 <1441071594-15941-3-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150901045945.GC13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 31 Aug 18:39 PDT 2015, Stephen Boyd wrote:

> We already have a function to do this and it silences some sparse
> warnings along the way.
> 

Didn't know that, thanks. Do you know why there's no equivalent for
transfers in the other direction? Should we hack one up to do the same
simplification in smd_copy_from_fifo()?

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Regards,
Bjorn
