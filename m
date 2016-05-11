From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 11 May 2016 12:56:03 -0700
Subject: [Patch v4 3/8] firmware: qcom: scm: Use atomic SCM for cold boot
In-Reply-To: <1462976158-26016-4-git-send-email-andy.gross@linaro.org>
References: <1462976158-26016-1-git-send-email-andy.gross@linaro.org>
 <1462976158-26016-4-git-send-email-andy.gross@linaro.org>
Message-ID: <20160511195603.GW1256@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 11 May 07:15 PDT 2016, Andy Gross wrote:

> This patch changes the cold_set_boot_addr function to use atomic SCM
> calls.  cold_set_boot_addr required adding qcom_scm_call_atomic2 to
> support the two arguments going to the smc call.  Using atomic removes
> the need for memory allocation and instead places all arguments in
> registers.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn
