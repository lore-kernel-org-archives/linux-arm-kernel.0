From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Nov 2011 12:02:11 +0100
Subject: [PATCH v3 01/17] ARM: Make global handler and
 CONFIG_MULTI_IRQ_HANDLER mutually exclusive
In-Reply-To: <20111107094515.GA6939@totoro>
References: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
 <1320425871-30564-2-git-send-email-marc.zyngier@arm.com>
 <20111107094515.GA6939@totoro>
Message-ID: <CACRpkdYxPmNRwQQ_ykSkSn2vPpMuyYBLFk11-VrCne+Nigp0=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 7, 2011 at 10:45 AM, Jamie Iles <jamie@jamieiles.com> wrote:

> My VIC patches are using this so if it goes in through the GIC patches
> first then that would be great!

That sounds like you should create some common irqchip-consolidation
topic branch in ARM SoC or Russell's tree to get this properly stacked up?

Linus Walleij
