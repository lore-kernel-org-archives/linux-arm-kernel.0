From: agross@codeaurora.org (Andy Gross)
Date: Tue, 22 Sep 2015 11:47:20 -0500
Subject: [PATCH] spmi: Auto-populate driver.owner in spmi_driver_register()
In-Reply-To: <1441922780-14467-1-git-send-email-sboyd@codeaurora.org>
References: <1441922780-14467-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150922164720.GB28017@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 10, 2015 at 03:06:20PM -0700, Stephen Boyd wrote:
> Populate the owner field of the spmi driver when
> spmi_driver_register() is called in a similar fashion to how
> other *_driver_register() functions do it. This saves driver
> writers from having to do this themselves.
> 
> Cc: Andy Gross <agross@codeaurora.org>
> Cc: Gilad Avidov <gavidov@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Reviewed-by: Andy Gross <agross@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
