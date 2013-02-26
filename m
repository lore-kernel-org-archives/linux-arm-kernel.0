From: olof@lixom.net (Olof Johansson)
Date: Mon, 25 Feb 2013 23:05:40 -0800
Subject: [PATCH] irqchip: fix typo when moving gic_raise_softirq()
In-Reply-To: <512384D0.1010306@calxeda.com>
References: <1361281942-16885-1-git-send-email-javi.merino@arm.com>
 <512384D0.1010306@calxeda.com>
Message-ID: <20130226070540.GA10312@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 19, 2013 at 07:57:36AM -0600, Rob Herring wrote:
> On 02/19/2013 07:52 AM, Javi Merino wrote:
> > In b1cffebf (ARM: GIC: remove direct use of gic_raise_softirq)
> > gic_raise_softirq() was moved inside arch/arm/common/gic.c but in the
> > process it reverted by mistake a change to that function made by
> > 384a290 (ARM: gic: use a private mapping for CPU target interfaces).
> > This breaks multicluster systems on ARM.
> > 
> > This patch fixes the typo.
> > 
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: Rob Herring <rob.herring@calxeda.com>
> > Signed-off-by: Javi Merino <javi.merino@arm.com>
> 
> I wouldn't really call this a typo, but a rebasing error. Not really
> important though, so:
> 
> Acked-by: Rob Herring <rob.herring@calxeda.com>

Applied.


-Olof
