From: dsd@laptop.org (Daniel Drake)
Date: Wed, 14 Aug 2013 15:26:29 -0600
Subject: [PATCH v6 01/11] irqchip: move mmp irq driver
In-Reply-To: <1374833133-21119-2-git-send-email-haojian.zhuang@gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
 <1374833133-21119-2-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <CAMLZHHTeKN7N6AsgTySE0QLHBv8yq-00C31iue_swusXnG6=uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series affects 3 different subsystems: irqchip,
clocksource, clk. It's not clear from your submission who you are
expecting to review/merge this. Unless there is some prior agreement,
maybe it would be easier and clearer to divide this up by subsystem.
There doesn't seem to be any overlap/dependencies between the 3 parts.

On Fri, Jul 26, 2013 at 4:05 AM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> Move irq-mmp driver from mach-mmp directory into irqchip directory.

Might be worth a 1-line commit message, explaining the motivation
here: moving hardware support from arch/arm to drivers/

> Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>

Reviewed-by: Daniel Drake <dsd@laptop.org>
