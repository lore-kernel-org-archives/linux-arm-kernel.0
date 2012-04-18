From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Apr 2012 13:41:21 +0200
Subject: [PATCH v2 2/2] pinctrl: show pin name for pingroups in sysfs
In-Reply-To: <1334646046-467-2-git-send-email-b29396@freescale.com>
References: <1334646046-467-1-git-send-email-b29396@freescale.com>
 <1334646046-467-2-git-send-email-b29396@freescale.com>
Message-ID: <CACRpkdYhsOV-5FqXk3kesQaQtxE8it1QKq2jzcy3if4eQHYtUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 17, 2012 at 9:00 AM, Dong Aisheng <b29396@freescale.com> wrote:

> After change, when cat pingroups in sysfs, it becomes:
> root at freescale /sys/kernel/debug/pinctrl/20e0000.iomuxc$ cat pingroups
> registered pin groups:
> group: uart4grp-1
> pin 219 (MX6Q_PAD_KEY_ROW0)
> pin 218 (MX6Q_PAD_KEY_COL0)
>
> group: usdhc4grp-1
> pin 305 (MX6Q_PAD_SD4_CMD)
> pin 306 (MX6Q_PAD_SD4_CLK)
> pin 315 (MX6Q_PAD_SD4_DAT0)
> pin 316 (MX6Q_PAD_SD4_DAT1)
> pin 317 (MX6Q_PAD_SD4_DAT2)
> pin 318 (MX6Q_PAD_SD4_DAT3)
> pin 319 (MX6Q_PAD_SD4_DAT4)
> pin 320 (MX6Q_PAD_SD4_DAT5)
> pin 321 (MX6Q_PAD_SD4_DAT6)
> pin 322 (MX6Q_PAD_SD4_DAT7)

Applied with this bit copied into the commit message and Stepgen's ACK.

Thanks!
Linus Walleij
