From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 May 2017 11:24:59 +0100
Subject: [v5 1/4] ACPICA: IORT: Add Cavium ThunderX2 SMMUv3 model
 definition.
In-Reply-To: <3624921.NlXkYaVXxR@aspire.rjw.lan>
References: <1494415918-13770-1-git-send-email-gakula@caviumnetworks.com>
 <3122711.vgvub3W1fy@aspire.rjw.lan>
 <20170511084525.GA18839@arm.com>
 <3624921.NlXkYaVXxR@aspire.rjw.lan>
Message-ID: <20170512102459.GF26181@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 11, 2017 at 04:40:51PM +0200, Rafael J. Wysocki wrote:
> On Thursday, May 11, 2017 09:45:25 AM Will Deacon wrote:
> > On Thu, May 11, 2017 at 02:26:02AM +0200, Rafael J. Wysocki wrote:
> > > On Wednesday, May 10, 2017 05:01:55 PM Geetha sowjanya wrote:
> > > > From: Linu Cherian <linu.cherian@cavium.com>
> > > > 
> > > > Add SMMUv3 model definition for ThunderX2.
> > > > 
> > > > Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
> > > > Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
> > > 
> > > This is an ACPICA change, but you have not included the ACPICA maintainers
> > > into your original CC list (added now).
> > > 
> > > Bob, Lv, how should this be routed?
> > > 
> > > Do you want to apply this patch upstream first or can we make this change in
> > > Linux and upstream in parallel?  That shouldn't be a big deal, right?
> > 
> > I think we're still waiting for the updated IORT document to be published (I
> > think this should be in the next week or so), so I don't think we should
> > commit the new ID before that happens.
> 
> OK, thanks for the heads-up.
> 
> I think it's better to submit the actbl2.h update directly to ACPICA
> upstream when the doc is published and then work on top of that.

The doc is now published:

http://infocenter.arm.com/help/topic/com.arm.doc.den0049c/DEN0049C_IO_Remapping_Table.pdf

so the new model numbers are confirmed.

Cheers,

Will
