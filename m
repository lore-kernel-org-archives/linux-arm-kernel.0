From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 01 Jun 2015 11:05:52 +0200
Subject: [PATCH 1/4]:Add mbigen driver to support mbigen interrupt
 controller
In-Reply-To: <556C1CDC.1050508@arm.com>
References: <55692C29.60003@huawei.com> <556C1CDC.1050508@arm.com>
Message-ID: <1433149552.2361.41.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-06-01 at 09:50 +0100, Marc Zyngier wrote:
> On 30/05/15 04:19, majun (F) wrote:
> > This patch contains the mbigen device driver.
> > 
> > To support Mbigen device, irq-mbigen.c and mbi.h are added.
> > 
> > As a MSI interrupt controller, the mbigen is used as a child domain of
> > MSI domain just like PCI devices.
> > 
> > Change log:
> > --irq-mbigen.c: the driver of mbigen device.The mbigen irq domain is created here
> >    as child domain of MSI.
> > --Add CONFIG_MBIGEN_IRQ_DOMAIN enable this driver

Changelog below the "---" marker, please, so git will remove it when
applying the patch.
 
> > Signed-off-by: Yun Wu <wuyun.wu@huawei.com>
> > Signed-off-by: Ma Jun <majun258@huawei.com>
> 
> Who is the author of this patch? If that's you, then the SOB lines are
> in the wrong order. If not, then there should be a From line at the top.

Even if you're the author of this patch a From: line is needed.
Otherwise "majun (F) <majun258@huawei.com>" would become the author,
instead of "Ma Jun <majun258@huawei.com>", and "majun (F)" is probably
not your name.

Thanks,


Paul Bolle
