From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 12 Feb 2014 02:46:07 +0400
Subject: [PATCH] power: reset: msm - switch Kconfig to ARCH_QCOM depends
In-Reply-To: <1392150126-21744-1-git-send-email-galak@codeaurora.org>
References: <1392150126-21744-1-git-send-email-galak@codeaurora.org>
Message-ID: <CALT56yO7rq4SXRnNpZgtmJYhVXzKy7oxuj9pAxFmXtbdnd=osA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 12:22 AM, Kumar Gala <galak@codeaurora.org> wrote:
> We've split Qualcomm MSM support into legacy and multiplatform.  The reset
> driver is only relevant on the multiplatform supported SoCs so switch the
> Kconfig depends to ARCH_QCOM.
>
> Signed-off-by: Kumar Gala <galak@codeaurora.org>

Acked-by: Dmitry Eremin-Solenikov

> ---
> Dmitry, David,
>
> If you can ack this I'll send it via linux-qcom/arm-soc tree's

Please, go ahead.

>
> thanks



-- 
With best wishes
Dmitry
