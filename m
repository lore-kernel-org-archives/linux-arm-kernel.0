From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Mon, 14 Oct 2013 09:09:01 +0800
Subject: [PATCH 1/9] i2c: i2c-designware-platdrv: replace
 platform_driver_probe to support deferred probing
In-Reply-To: <1381264542-29396-2-git-send-email-wsa@the-dreams.de>
References: <1381264542-29396-1-git-send-email-wsa@the-dreams.de>
 <1381264542-29396-2-git-send-email-wsa@the-dreams.de>
Message-ID: <CAMj5BkgLEe5ODb7KRhb8F0b7JjG6Tf8AdheokO2jyQLbSj7_mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 9, 2013 at 4:35 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> Subsystems like pinctrl and gpio rightfully make use of deferred probing at
> core level. Now, deferred drivers won't be retried if they don't have a .probe
> function specified in the driver struct. Fix this driver to have that, so the
> devices it supports won't get lost in a deferred probe.
>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Zhangfei Gao <zhangfei.gao@linaro.org>

Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Thanks
