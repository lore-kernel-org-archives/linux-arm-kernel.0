From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 3 Nov 2014 17:51:21 +0100
Subject: [PATCH v3 02/19] arm/arm64: KVM: pass down user space provided
 GIC type into vGIC code
In-Reply-To: <54578237.3080900@arm.com>
References: <1414776414-13426-1-git-send-email-andre.przywara@arm.com>
 <1414776414-13426-3-git-send-email-andre.przywara@arm.com>
 <20141103131425.GC16132@cbox> <54578237.3080900@arm.com>
Message-ID: <20141103165121.GH16132@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 03, 2014 at 01:25:11PM +0000, Andre Przywara wrote:
> Hi Christoffer,
> 
> On 03/11/14 13:14, Christoffer Dall wrote:
> > On Fri, Oct 31, 2014 at 05:26:37PM +0000, Andre Przywara wrote:
> >> With the introduction of a second emulated GIC model we need to let
> >> userspace specify the GIC model to use for each VM. Pass the
> >> userspace provided value down into the vGIC code and store it there
> >> to differentiate later.
> >>
> >> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > 
> > Did you change anything since v2?
> 
> Yes (and that's why I dropped your ack):
> I moved the line that stores the vgic_model from the "introduce
> per-VM-ops" patch into here (plus the declaration of it):
> 
> 	kvm->arch.vgic.vgic_model = type;
> 
> That was part of the split-up to make that bigger patch more readable.
> 
ok, it fits perfectly her:

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
