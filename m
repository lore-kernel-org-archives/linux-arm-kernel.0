From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 13 May 2016 16:37:14 -0700
Subject: [Patch v5 3/8] firmware: qcom: scm: Use atomic SCM for cold boot
In-Reply-To: <1463111221-6963-4-git-send-email-andy.gross@linaro.org>
References: <1463111221-6963-1-git-send-email-andy.gross@linaro.org>
 <1463111221-6963-4-git-send-email-andy.gross@linaro.org>
Message-ID: <20160513233714.GG1256@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 12 May 20:46 PDT 2016, Andy Gross wrote:

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
