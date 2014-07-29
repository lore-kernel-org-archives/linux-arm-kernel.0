From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Jul 2014 23:40:27 -0700
Subject: [PATCH v5 0/8] enable Hisilicon HIX5HD2 SoC
In-Reply-To: <1406551883-26154-1-git-send-email-haojian.zhuang@linaro.org>
References: <1406551883-26154-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <20140729064027.GE32359@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 28, 2014 at 08:51:15PM +0800, Haojian Zhuang wrote:
> Changelog:
> v5:
>   * Use CPU_OF_DECLARE_METHOD().
>   * State "hisilicon,cpuctrl" in documents.
>   * Set PL310 L2 aux value in machine descriptor.
>   * Use enable-method property for smp in dts file.
>   * Move reset code from machine platform driver into power reset driver.
>   * Move HIP04 debug uart into another patch series.

Usually there's some more description in the cover letter than just the
changelog.

Anyway, my question is this: what's the plan for upstreaming of this SoC? Is it
a mobile-only SoC, or has it been used (or will it be used) in other embedded
use cases, public development boards and the like?

If it is a mobile-targeted product, what is the plan and rough timeline
for upstreaming things such as display/graphics and power management
components?


Thanks!


-Olof
