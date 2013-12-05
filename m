From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 4 Dec 2013 16:28:46 -0800
Subject: [GIT PULL][for 3.14] pull request for hisilicon clock driver
In-Reply-To: <529F0C4E.4080501@gmail.com>
References: <529F0C4E.4080501@gmail.com>
Message-ID: <CAPtuhTibU4yTmoNdD-gsV6fp1gqMMjphvvHdCoF8a1r+zf_csA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 4, 2013 at 3:04 AM, Haojian Zhuang <haojian.zhuang@gmail.com> wrote:
> Hi Mike,
>
> Please help to merge this hisilicon clock driver.
>
> Regards
> Haojian
>
> The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:
>
>   Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)
>
> are available in the git repository at:
>
> ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/hzhuang1/linux.git
> tags/clk-hisilicon

Is there an anonymous ssh user that I can use to pull this? Otherwise
I cannot authenticate ;-)

Alternatively you could provide an https:// or git:// URI for me to pull.

Thanks!
Mike

>
> for you to fetch changes up to 0aa0c95f743a06893dbc494b2a75fbf7093330d4:
>
>   clk: hisilicon: add common clock support (2013-12-04 18:36:45 +0800)
>
> ----------------------------------------------------------------
> clock driver for hisilicon
>
> ----------------------------------------------------------------
> Haojian Zhuang (1):
>       clk: hisilicon: add common clock support
>
>  Documentation/devicetree/bindings/clock/hi3620-clock.txt |  19 +++++++
>  drivers/clk/Makefile                                     |   1 +
>  drivers/clk/hisilicon/Makefile                           |   5 ++
>  drivers/clk/hisilicon/clk-hi3620.c                       | 242
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/hisilicon/clk.c                              | 171
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/hisilicon/clk.h                              | 103
> ++++++++++++++++++++++++++++++++++++
>  drivers/clk/hisilicon/clkgate-separated.c                | 130
> ++++++++++++++++++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/hi3620-clock.h                 | 152
> +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  8 files changed, 823 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/hi3620-clock.txt
>  create mode 100644 drivers/clk/hisilicon/Makefile
>  create mode 100644 drivers/clk/hisilicon/clk-hi3620.c
>  create mode 100644 drivers/clk/hisilicon/clk.c
>  create mode 100644 drivers/clk/hisilicon/clk.h
>  create mode 100644 drivers/clk/hisilicon/clkgate-separated.c
>  create mode 100644 include/dt-bindings/clock/hi3620-clock.h
>
