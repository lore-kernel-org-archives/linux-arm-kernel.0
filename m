From: john.stultz@linaro.org (John Stultz)
Date: Thu, 8 Sep 2016 12:04:46 -0700
Subject: [PATCH 3/3] config: android: enable CONFIG_SECCOMP
In-Reply-To: <20160908185934.18098-3-robh@kernel.org>
References: <20160908185934.18098-1-robh@kernel.org>
 <20160908185934.18098-3-robh@kernel.org>
Message-ID: <CALAqxLW6b+PAm9NONHN7_8YyzPtGf4_phAG1VLWADsxKmfxJ3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2016 at 11:59 AM, Rob Herring <robh@kernel.org> wrote:
> As of Android N, SECCOMP is required. Without it, we will get
> mediaextractor error:
>
> E /system/bin/mediaextractor: libminijail: prctl(PR_SET_SECCOMP, SECCOMP_MODE_FILTER): Invalid argument
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john
