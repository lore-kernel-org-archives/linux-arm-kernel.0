From: mtosatti@redhat.com (Marcelo Tosatti)
Date: Wed, 25 Mar 2015 18:41:55 -0300
Subject: [PATCH v2 04/12] KVM: x86: remove now unneeded include directory
 from Makefile
In-Reply-To: <5512EA00.2070105@arm.com>
References: <1427126309-11223-1-git-send-email-andre.przywara@arm.com>
 <1427126309-11223-5-git-send-email-andre.przywara@arm.com>
 <5512EA00.2070105@arm.com>
Message-ID: <20150325214155.GD3649@amt.cnet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 25, 2015 at 05:01:52PM +0000, Marc Zyngier wrote:
> On 23/03/15 15:58, Andre Przywara wrote:
> > virt/kvm was never really a good include directory for anything else
> > than locally included headers.
> > With the move of iodev.h there is no need anymore to add this
> > directory the compiler's include path, so remove it from the x86 kvm
> > Makefile.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> 
> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> 
> Paolo, Marcelo: can we have your Ack on this?
> 
> Thanks,
> 
> 	M.

Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
