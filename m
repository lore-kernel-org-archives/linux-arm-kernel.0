From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Fri, 23 Oct 2015 13:22:44 -0700
Subject: [PATCH v3 3/4] soc: qcom: smd: Use __ioread32_copy() instead of
 open-coding it
In-Reply-To: <1445630512-10888-4-git-send-email-sboyd@codeaurora.org>
References: <1445630512-10888-1-git-send-email-sboyd@codeaurora.org>
 <1445630512-10888-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20151023202244.GX24668@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 23 Oct 13:01 PDT 2015, Stephen Boyd wrote:

> Now that we have a generic library function for this, replace the
> open-coded instance.
> 
> Cc: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
