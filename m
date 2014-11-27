From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Nov 2014 16:55:53 -0800
Subject: [PATCH v12 02/10] qcom: scm: Add SCM warmboot support for quad
 core SoCs
In-Reply-To: <1417047195-18978-3-git-send-email-lina.iyer@linaro.org>
References: <1417047195-18978-1-git-send-email-lina.iyer@linaro.org>
 <1417047195-18978-3-git-send-email-lina.iyer@linaro.org>
Message-ID: <54767699.1030001@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2014 04:13 PM, Lina Iyer wrote:
> Quad core SoCs like APQ8074, APQ8064, APQ8084 need SCM support set up
> warm boot addresses in the Secure Monitor. Extend the SCM flags to
> support warm boot addresses for secondary cores.
>
> We do not need to export the warmboot flags. Move them into the
> implementation file.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
