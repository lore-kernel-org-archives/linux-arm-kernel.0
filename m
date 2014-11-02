From: jszhang@marvell.com (Jisheng Zhang)
Date: Sun, 2 Nov 2014 13:44:16 +0800
Subject: [PATCH v2] irqchip: dw-apb-ictl: select GENERIC_IRQ_CHIP
In-Reply-To: <20141102022311.GS3698@titan.lakedaemon.net>
References: <1413982750-832-1-git-send-email-jszhang@marvell.com>
 <20141102022311.GS3698@titan.lakedaemon.net>
Message-ID: <20141102134416.1679e632@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 1 Nov 2014 19:23:11 -0700
Jason Cooper <jason@lakedaemon.net> wrote:

> Jisheng,
> 
> On Wed, Oct 22, 2014 at 08:59:10PM +0800, Jisheng Zhang wrote:
> > The dw-apb-ictl driver uses the generic-chip functions.
> > Thus it needs to select GENERIC_IRQ_CHIP in Kconfig.
> > 
> > Change-Id: If748beffc4e0d0b47062bb067a59c10994a9148b
> 
> Please don't include this is future patches.

oops, sorry for my fault. I'll take care from now on.

Thanks for kindly reminding,
Jisheng
