From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 02 Feb 2015 13:01:16 -0600
Subject: [PATCH v8 20/21] Documentation: ACPI for ARM64
In-Reply-To: <1422881149-8177-21-git-send-email-hanjun.guo@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-21-git-send-email-hanjun.guo@linaro.org>
Message-ID: <54CFC97C.3080402@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/02/2015 06:45 AM, Hanjun Guo wrote:
> From: Graeme Gregory <graeme.gregory@linaro.org>
>
> Add documentation for the guidelines of how to use ACPI
> on ARM64.

This patch has a slight corruption to it:

In-Reply-To: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=n
                                   ^
git-am chokes on this:

	fatal: cannot convert from n to UTF-8

Replacing the 'n' with '"us-ascii"' fixes it.

Patch #21 has the same problem, although it also has a trailing 
whitespace problem.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
