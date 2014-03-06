From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Thu, 6 Mar 2014 12:04:07 +0530
Subject: [PATCH 2/2] dt-bindings: clock: Move exynos-audss-clk.h to
 dt-bindings/clock
In-Reply-To: <1394085884-13081-3-git-send-email-tushar.behera@linaro.org>
References: <1394085884-13081-1-git-send-email-tushar.behera@linaro.org>
 <1394085884-13081-3-git-send-email-tushar.behera@linaro.org>
Message-ID: <CAK9yfHwLRV_Wj+O=tNEGWw2g4oR9t1-O9bNwozfwv+WOPkjpoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 March 2014 11:34, Tushar Behera <tushar.behera@linaro.org> wrote:
> Most of the clock related dt-binding header files are located in
> dt-bindings/clock folder. It would be good to keep all the similar
> header files at a single location.
>
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> CC: Kukjin Kim <kgene.kim@samsung.com>
> CC: Tomasz Figa <t.figa@samsung.com>
> ---

Sensible move.
Reviewed-by: Sachin Kamat <sachin.kamat@linaro.org>

Now that the dt-bindings/clk folder is empty (with these 2 patches
applied), it can be deleted as well.

-- 
With warm regards,
Sachin
