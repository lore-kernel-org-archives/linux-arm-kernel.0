From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 31 Mar 2016 16:31:54 +0200
Subject: [RFC PATCH 12/45] KVM: arm/arm64: vgic-new: Add MMIO handling
 framework
In-Reply-To: <56FD171E.1040401@redhat.com>
References: <1458871508-17279-1-git-send-email-andre.przywara@arm.com>
 <1458871508-17279-13-git-send-email-andre.przywara@arm.com>
 <20160331090824.GR4126@cbox>
 <CAMJs5B_5onpRW3DYGqO=LXc2RTM7OQV6itcfQJMy+PuR29c85w@mail.gmail.com>
 <56FD171E.1040401@redhat.com>
Message-ID: <20160331143154.GB20251@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 02:25:02PM +0200, Paolo Bonzini wrote:
> 
> 
> On 31/03/2016 11:09, Christoffer Dall wrote:
> >> My comments to Vladimir's bug report notwithstanding, there's still a
> >> choice here to:
> >>
> >> 1) Expand/modify the KVM IO bus framework to take an arbitrary number of devices
> >>
> >> 2) Build a KVM architectureal generic framework on top of the IO bus
> >> framework to handle individual register regions.
> >>
> >> 3) Stick with what we had before, do not modify the KVM IO bus stuff,
> >> and handle the individual register region business locally within the
> >> arm/vgic code.
> 
> I prefer 3, or alternatively just add the framework in virt/kvm/arm so
> that it can be migrated to virt/kvm if someone else needs it.
> 
Sounds like a plan.  Thanks Paolo.

-Christoffer
