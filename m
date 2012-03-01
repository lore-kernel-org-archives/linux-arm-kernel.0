From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 01 Mar 2012 10:33:47 +0100
Subject: [PATCH 2/4] ARM: EXYNOS: Add __init attribute to
 universal_camera_init()
In-Reply-To: <1330593446-663-3-git-send-email-tushar.behera@linaro.org>
References: <1330593446-663-1-git-send-email-tushar.behera@linaro.org>
 <1330593446-663-3-git-send-email-tushar.behera@linaro.org>
Message-ID: <4F4F427B.3030502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2012 10:17 AM, Tushar Behera wrote:
> s3c_set_platdata() is defined with __init attribute, hence all functions
> referencing this function should also be defined with __init attribute.
> 
> universal_camera_init() is referenced only in '__init universal_machine_init()',
> thus this change won't put any additional constraint on the usage of
> universal_camera_init().
> 
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>

Thanks.

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
