From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Fri, 14 Aug 2015 22:50:28 -0700
Subject: [Patch v2] soc: qcom: smem: Fix errant private access
In-Reply-To: <1439614619-29808-1-git-send-email-agross@codeaurora.org>
References: <1439614619-29808-1-git-send-email-agross@codeaurora.org>
Message-ID: <20150815055028.GN13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 14 Aug 21:56 PDT 2015, Andy Gross wrote:

> This patch corrects private partition item access.  Instead of falling back to
> global for instances where we have an actual host and remote partition existing,
> return the results of the private lookup.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>

Thanks for finding this issue.

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
