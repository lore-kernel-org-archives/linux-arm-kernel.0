From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Fri, 28 Aug 2015 12:53:16 -0700
Subject: [PATCH] soc: qcom: smem: Avoid NULL pointer exception on remove
In-Reply-To: <1440785929-22441-1-git-send-email-sboyd@codeaurora.org>
References: <1440785929-22441-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150828195316.GS13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 28 Aug 11:18 PDT 2015, Stephen Boyd wrote:

> Don't set a pointer to NULL and then dereference it in the next
> line.
> 

Sorry about that.

Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>

Regards,
Bjorn
