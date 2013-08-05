From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Mon, 5 Aug 2013 10:13:14 +0800
Subject: [PATCH v4 0/2] support hisilicon i2c
In-Reply-To: <1374844938-25505-1-git-send-email-zhangfei.gao@linaro.org>
References: <1374844938-25505-1-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <CAMj5BkjMw2oxWy5+fgT9hoHLT-DiSv6u7zSzAhi8B_d-=-v8Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 9:22 PM, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
> V4:
> rebase on 3.11
>
> v3:
> patch 02, use size instead of threshold
>
> v2:
> Suggested by Baruch
> Support hisilicon i2c in i2c-designware-platdrv.c, and adding two optional properties
>
> Zhangfei Gao (2):
>   i2c: designware: use module_platform_driver
>   i2c: designware: add two optional property tx/rx-fifo-size
>
>  .../devicetree/bindings/i2c/i2c-designware.txt     |    7 +++++++
>  drivers/i2c/busses/i2c-designware-platdrv.c        |   17 +++++------------
>  2 files changed, 12 insertions(+), 12 deletions(-)
>

"Basically OK, but please resend for 3.12, so we get enough testing
before entering mainline. I am a bit anxious of side
effects and 3.11 is too near."

Dear Wolfram

The patches are rebased on 3.11 rc2 as your suggestion,
Do you have any other suggestion?

Thanks
