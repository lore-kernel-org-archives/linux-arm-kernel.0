From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 13 Oct 2016 14:59:10 -0500
Subject: [PATCH] arm64: kaslr: fix breakage with CONFIG_MODVERSIONS=y
In-Reply-To: <1476376929-29688-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1476376929-29688-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <57FFE78E.4040002@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ard Biesheuvel wrote:
> As it turns out, the KASLR code breaks CONFIG_MODVERSIONS, since the
> kcrctab has an absolute address field that is relocated at runtime
> when the kernel offset is randomized.
>
> This has been fixed already for PowerPC in the past, so simply wire up
> the existing code dealing with this issue.
>
> Signed-off-by: Ard Biesheuvel<ard.biesheuvel@linaro.org>

Tested-by: Timur Tabi <timur@codeaurora.org>

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
