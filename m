From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 11 Aug 2018 00:48:19 +0800
Subject: [PATCH] clk: sunxi-ng: h6: fix PWM gate/reset offset
In-Reply-To: <20180810151638.30900-1-icenowy@aosc.io>
References: <20180810151638.30900-1-icenowy@aosc.io>
Message-ID: <CAGb2v66Wsjvz8Pdo+7JDHudOxqqWX_9qMX4kgiFHo8cJJou7Ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 10, 2018 at 11:16 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> From: Rongyi Chen <chenyi@tt-cool.com>
>
> Currently the register offset of the PWM bus gate in Allwinner H6 clock
> driver is wrong.
>
> Fix this issue.
>
> Fixes: 542353ea ("clk: sunxi-ng: add support for the Allwinner H6 CCU")
> Signed-off-by: Rongyi Chen <chenyi@tt-cool.com>
> [Icenowy: refactor commit message]
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Queued up for 4.20. Thanks

ChenYu
