From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 15 Oct 2013 21:37:46 -0700
Subject: [PATCH] KVM: ARM: Update comments for kvm_handle_wfi
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D071BDCAD@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1381253894-18114-2-git-send-email-marc.zyngier@arm.com>
 <1381886000-11140-1-git-send-email-christoffer.dall@linaro.org>
 <6A3DF150A5B70D4F9B66A25E3F7C888D071BDCAD@039-SN2MPN1-013.039d.mgd.msft.net>
Message-ID: <20131016043746.GC24837@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 04:19:45AM +0000, Bhushan Bharat-R65777 wrote:
> 
> 
> > -----Original Message-----
> > From: Christoffer Dall [mailto:christoffer.dall at linaro.org]
> > Sent: Wednesday, October 16, 2013 6:43 AM
> > To: Marc Zyngier
> > Cc: kvmarm at lists.cs.columbia.edu; linux-arm-kernel at lists.infradead.org
> > Subject: [PATCH] KVM: ARM: Update comments for kvm_handle_wfi
> > 
> > Update comments to reflect what is really going on and add the TWE bit to the
> > comments in kvm_arm.h.
> > 
> > Also renames the function to kvm_handle_wfx like is done on arm64 for
> > consistency and uber-correctness.
> 
> s/uber/user
> 
No, that was actually the German word "uber" (with the dots, but I
didn't want to put them), with the meaning very very correct.  My
attempt at humor failed here miserably I see :)

-Christoffer
