From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 29 Aug 2013 11:24:06 -0700
Subject: [PATCH v9 6/7] ARM: hi3xxx: add smp support
In-Reply-To: <1377695454-29109-7-git-send-email-haojian.zhuang@linaro.org>
 (Haojian Zhuang's message of "Wed, 28 Aug 2013 21:10:53 +0800")
References: <1377695454-29109-1-git-send-email-haojian.zhuang@linaro.org>
 <1377695454-29109-7-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <87wqn4z77d.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Haojian Zhuang <haojian.zhuang@linaro.org> writes:

> From: Zhangfei Gao <zhangfei.gao@linaro.org>
>
> Enable SMP support on hi3xxx platform
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Zhang Mingjun <zhang.mingjun@linaro.org>
> Tested-by: Li Xin <li.xin@linaro.org>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>

> ---
>  .../bindings/arm/hisilicon/hisilicon.txt           | 50 +++++++++++++++++

New/extended bindings need review/ack from the DT maintainers.  Please
be sure to Cc: devicetree at vger.kernel.org on patches with new/updated
bindings.

Kevin
