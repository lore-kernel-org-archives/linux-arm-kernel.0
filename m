From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Thu, 3 Sep 2015 10:02:08 -0700
Subject: [PATCH v2 1/8] soc: qcom: Make qcom_smem_get() return a pointer
In-Reply-To: <1441234011-4259-2-git-send-email-sboyd@codeaurora.org>
References: <1441234011-4259-1-git-send-email-sboyd@codeaurora.org>
 <1441234011-4259-2-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150903170208.GP13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 02 Sep 15:46 PDT 2015, Stephen Boyd wrote:

> Passing a void ** almost always requires a cast at the call site.
> Instead of littering the code with casts every time this function
> is called, have qcom_smem_get() return a void pointer to the
> location of the smem item. This frees the caller from having to
> cast the pointer.
> 
Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
