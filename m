From: lars.persson@axis.com (Lars Persson)
Date: Thu, 12 Nov 2015 12:10:12 +0100
Subject: [PATCH v2 2/4] arm: add implementation for arm-smccc
In-Reply-To: <1447236266-7491-3-git-send-email-jens.wiklander@linaro.org>
References: <1447236266-7491-1-git-send-email-jens.wiklander@linaro.org>
 <1447236266-7491-3-git-send-email-jens.wiklander@linaro.org>
Message-ID: <56447394.2090201@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/11/2015 11:04 AM, Jens Wiklander wrote:
> Adds implementation for arm-smccc and enables CONFIG_HAVE_SMCCC for
> architectures that may support arm-smccc. It's the responsibility of the
> caller to know if the SMC instruction is supported by the platform.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Reviewed-by: Lars Persson <lars.persson@axis.com>
