From: drjones@redhat.com (Andrew Jones)
Date: Fri, 16 Mar 2018 12:35:07 +0100
Subject: [PATCH v6 06/26] KVM: arm/arm64: Do not use kern_hyp_va() with
 kvm_vgic_global_state
In-Reply-To: <98ec10c0-73a3-db00-b78b-2777c0874968@arm.com>
References: <20180314165049.30105-1-marc.zyngier@arm.com>
 <20180314165049.30105-7-marc.zyngier@arm.com>
 <5AAAC67E.4010002@arm.com>
 <98ec10c0-73a3-db00-b78b-2777c0874968@arm.com>
Message-ID: <20180316113507.apyvlsvekvjm36ix@kamzik.brq.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2018 at 09:31:57AM +0000, Marc Zyngier wrote:
> On 15/03/18 19:16, James Morse wrote:
> > 
> > (I had a go at using 'Ush', to let the compiler schedule the adrp, but couldn't
> > get it to work.)
> 
> I tried that as well at some point, but couldn't see how to use it. The
> compiler was never happy with my use of the constraints, so I gave up
> and did it my way...
>

What's 'Ush'? I tried to search for it, but came up short. I'm wondering
what things I can try (and fail) to use it on too :-)

Thanks,
drew
