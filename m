From: romeusmeister@gmail.com (Roman Storozhenko)
Date: Tue, 27 Jun 2017 15:06:26 +0300
Subject: [PATCH] KVM: Replaces 'unsigned' with 'unsigned int' in the
 codebase
In-Reply-To: <9b50ee4b-d27a-8872-0cd3-cad8f5f0e0f8@redhat.com>
References: <20170627095401.GA19864@home>
 <9b50ee4b-d27a-8872-0cd3-cad8f5f0e0f8@redhat.com>
Message-ID: <20170627120626.GA21666@home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 12:01:25PM +0200, Paolo Bonzini wrote:
> 
> 
> On 27/06/2017 11:54, Roman Storozhenko wrote:
> > Signed-off-by: Roman Storozhenko <romeusmeister@gmail.com>
> > ---
> >  virt/kvm/arm/arm.c        |  2 +-
> >  virt/kvm/coalesced_mmio.c |  2 +-
> >  virt/kvm/eventfd.c        | 10 ++++++----
> >  virt/kvm/irqchip.c        |  7 ++++---
> >  virt/kvm/kvm_main.c       | 16 ++++++++--------
> >  5 files changed, 20 insertions(+), 17 deletions(-)
> 
> This change is pointless.  Contributors to KVM should know what
> "unsigned" means.

Paolo, thanks that you mentioned this. But I have a question - is this just
useless or this is an error?

I saw many places in the codebase where 'unsigned int' is used. That why I
decided to make the codebase more standartized from the style point of
view.

Thanks, Roman Storozhenko.
