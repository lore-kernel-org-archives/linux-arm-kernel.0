From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 12 Aug 2015 13:45:43 +0200
Subject: [PATCH v4 06/11] KVM: arm/arm64: vgic: Allow dynamic mapping of
 physical/virtual interrupts
In-Reply-To: <20150812105638.67de9423@arm.com>
References: <1438962347-17541-1-git-send-email-marc.zyngier@arm.com>
 <1438962347-17541-7-git-send-email-marc.zyngier@arm.com>
 <20150811074221.GC5007@lvm> <20150812105638.67de9423@arm.com>
Message-ID: <20150812114543.GA15085@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 10:56:38AM +0100, Marc Zyngier wrote:
> On Tue, 11 Aug 2015 08:42:37 +0100
> Christoffer Dall <christoffer.dall@linaro.org> wrote:
> 
> > On Fri, Aug 07, 2015 at 04:45:42PM +0100, Marc Zyngier wrote:
> > > In order to be able to feed physical interrupts to a guest, we need
> > > to be able to establish the virtual-physical mapping between the two
> > > worlds.
> > > 
> > > The mappings are kept in a set of RCU lists, indexed by virtual interrupts.
> > > 
> > > Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> > 
> > Thanks for addressing all my concerns:
> > 
> > Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> 
> Thanks a lot for all the reviewing, much appreciated.
> 
> Unless someone has an objection, I'm going put this series (minus
> the last patch) into -next so it gets a bit more exposure.
> 

Sounds good to me, when I'm back from this paper writing business
tomorrow/friday, I'll give it a spin and test the UEFI reboot issue with
it as well.

-Christoffer
