From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Wed, 29 Feb 2012 14:12:09 +0530
Subject: [PATCH 1/2] ARM: add cpufreq transiton notifier to adjust
 loops_per_jiffy for smp
In-Reply-To: <1330499895-12364-2-git-send-email-richard.zhao@linaro.org>
References: <1330499895-12364-1-git-send-email-richard.zhao@linaro.org>
 <1330499895-12364-2-git-send-email-richard.zhao@linaro.org>
Message-ID: <CAMQu2gxwb8=Pn6tp6SCc+G=juUUtfXfe5wuLAD8f0fDVJqwpEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 29, 2012 at 12:48 PM, Richard Zhao <richard.zhao@linaro.org> wrote:
> If CONFIG_SMP, cpufreq skips loops_per_jiffy update, because different
> arch has different per-cpu loops_per_jiffy definition.
>
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
