From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 7 Nov 2011 11:17:01 +0000
Subject: [PATCH v3 01/17] ARM: Make global handler and
 CONFIG_MULTI_IRQ_HANDLER mutually exclusive
In-Reply-To: <4EB7BD09.5010902@arm.com>
References: <1320425871-30564-1-git-send-email-marc.zyngier@arm.com>
 <1320425871-30564-2-git-send-email-marc.zyngier@arm.com>
 <20111107094515.GA6939@totoro>
 <CACRpkdYxPmNRwQQ_ykSkSn2vPpMuyYBLFk11-VrCne+Nigp0=Q@mail.gmail.com>
 <4EB7BD09.5010902@arm.com>
Message-ID: <20111107111701.GB6939@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2011 at 11:12:09AM +0000, Marc Zyngier wrote:
> On 07/11/11 11:02, Linus Walleij wrote:
> > On Mon, Nov 7, 2011 at 10:45 AM, Jamie Iles <jamie@jamieiles.com> wrote:
> > 
> >> My VIC patches are using this so if it goes in through the GIC patches
> >> first then that would be great!
> > 
> > That sounds like you should create some common irqchip-consolidation
> > topic branch in ARM SoC or Russell's tree to get this properly stacked up?
> 
> Sounds like a good idea to me. I'm willing to gather such patches if
> nobody else steps up.

Great, thanks Marc!  I'm happy to rebase my branch onto any point so you 
can easily pull if that makes things easier.

Thanks,

Jamie
