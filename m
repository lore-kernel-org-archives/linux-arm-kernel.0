From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 22 Apr 2016 16:13:17 -0700
Subject: [PATCH 3/8] firmware: qcom: scm: Generalize shared error map
In-Reply-To: <1461363432-5730-4-git-send-email-andy.gross@linaro.org>
References: <1461363432-5730-1-git-send-email-andy.gross@linaro.org>
 <1461363432-5730-4-git-send-email-andy.gross@linaro.org>
Message-ID: <20160422231317.GF3202@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 22 Apr 15:17 PDT 2016, Andy Gross wrote:

> This patch moves the qcom_scm_remap_error function to the include file
> where can be used by both the 32 and 64 bit versions of the code.
> 
> Signed-off-by: Andy Gross <agross@codeaurora.org>
> Signed-off-by: Andy Gross <andy.gross@linaro.org>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
