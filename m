From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 21 Mar 2012 15:11:12 +0530
Subject: [RFC][PATCH 1/7] ARM: OMAP4: cpuidle - Remove unused valid field
In-Reply-To: <1332322070-24577-2-git-send-email-daniel.lezcano@linaro.org>
References: <1332322070-24577-1-git-send-email-daniel.lezcano@linaro.org>
 <1332322070-24577-2-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CAMQu2gw+GGnpG_s6TCk2fH094Lfmj1zgAZqQ4zdQmpj3ZZhu3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2012 at 2:57 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> The 'valid' field is never used in the code, let's remove it.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
It is used during the registration. This field has been very useful for
debug when need to disable a C-state etc.
So unless and until there is a strong reason, i would like to retain it.

Regards
Santosh
