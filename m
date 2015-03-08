From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 8 Mar 2015 05:38:28 +0000
Subject: [PATCH v2 0/7] ARM: mvebu: Enable perf support
In-Reply-To: <1425379400-4346-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1425379400-4346-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150308053828.GG21207@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 11:43:13AM +0100, Maxime Ripard wrote:
...
> Ezequiel Garcia (5):
>   irqchip: armada-370-xp: Initialize per cpu registers when CONFIG_SMP=N
>   irqchip: armada-370-xp: Introduce a is_percpu_irq() helper for
>     readability
...
> 
> Maxime Ripard (2):
>   irqchip: armada-370-xp: Enable the PMU interrupts
...
>  arch/arm/configs/mvebu_v7_defconfig  |  1 +
>  drivers/irqchip/irq-armada-370-xp.c  | 88 +++++++++++++++++++++++-------------
>  5 files changed, 73 insertions(+), 31 deletions(-)

Patches 1-3 applied to irqchip/mvebu with Gregory's Acks.  Please let me know
if you need to use this as a base.

Depends on the fix in irqchip/urgent.

thx,

Jason.
