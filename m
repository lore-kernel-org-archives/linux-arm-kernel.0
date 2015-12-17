From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Thu, 17 Dec 2015 15:59:13 +0530
Subject: [PATCH] clocksource: arm_global_timer: Allow DT to specify
 already reset timer counter
In-Reply-To: <567289AD.5000209@arm.com>
References: <1448429044-10395-1-git-send-email-jaswinder.singh@linaro.org>
 <5670559A.4050404@linaro.org>
 <CABb+yY0_JvVV_HG_iU8KJjmwu-nq_Cu5hJ6HBoKZCrZAdJ=rLQ@mail.gmail.com>
 <56710BD6.2090502@linaro.org>
 <CAJe_Zher2N-jFOBiA-25u0fQv_mdps+_Y4FoFdjiw9E++87TLg@mail.gmail.com>
 <567289AD.5000209@arm.com>
Message-ID: <CAJe_Zhdj6sroEuAzFyphCc-Ge3S70TqpZpWxicSxvO2FBOd-Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 December 2015 at 15:38, Marc Zyngier <marc.zyngier@arm.com> wrote:
...
> Why can't you
> simply get the firmware to *remove* the node from your device tree
> altogether?
>
... but Linux (on cpu1) and the other OS (on cpu0) both _need_ to use the GT.

Thanks.
