From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Thu, 17 Dec 2015 15:54:55 +0530
Subject: [PATCH] clocksource: arm_global_timer: Allow DT to specify
 already reset timer counter
In-Reply-To: <56728B87.8030409@linaro.org>
References: <1448429044-10395-1-git-send-email-jaswinder.singh@linaro.org>
 <5670559A.4050404@linaro.org>
 <CABb+yY0_JvVV_HG_iU8KJjmwu-nq_Cu5hJ6HBoKZCrZAdJ=rLQ@mail.gmail.com>
 <56710BD6.2090502@linaro.org>
 <CAJe_Zher2N-jFOBiA-25u0fQv_mdps+_Y4FoFdjiw9E++87TLg@mail.gmail.com>
 <56728B87.8030409@linaro.org>
Message-ID: <CAJe_ZhfEX-G_EinjLG7_-k4cE7=z_bkoiQAumzLU=hzMmz7a0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 December 2015 at 15:46, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> I don't know if there is a better way than a kernel parameter but IMO it
> makes sense to pass this kind of options via the kernel command line as we
> can extend it easily for more options in the future.
>
I agree, for such 'soft' properties, cmdline is a better option.

Thanks.
