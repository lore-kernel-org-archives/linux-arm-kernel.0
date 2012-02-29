From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 29 Feb 2012 14:12:42 +0530
Subject: [PATCH 2/2] cpufreq: OMAP: remove loops_per_jiffy recalculate for
 smp
In-Reply-To: <1330499895-12364-3-git-send-email-richard.zhao@linaro.org>
References: <1330499895-12364-1-git-send-email-richard.zhao@linaro.org>
 <1330499895-12364-3-git-send-email-richard.zhao@linaro.org>
Message-ID: <CAMQu2gw-xD2iG397Fw7KEVLNAM_y3ccv=vjB-mtTOeASVDoy-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 12:48 PM, Richard Zhao <richard.zhao@linaro.org> wrote:
> arm registered cpufreq transition notifier to recalculate it.
>
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
Thanks for the OMAP updates
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
