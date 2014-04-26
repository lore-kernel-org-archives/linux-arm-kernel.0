From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 26 Apr 2014 04:25:31 -0700
Subject: [PATCH] ARM: KVM: disable KVM in Kconfig on big-endian systems
In-Reply-To: <535A593C.6020408@arm.com>
References: <1398422764-29351-1-git-send-email-will.deacon@arm.com>
 <535A593C.6020408@arm.com>
Message-ID: <20140426112531.GB8221@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 01:46:52PM +0100, Marc Zyngier wrote:
> On 25/04/14 11:46, Will Deacon wrote:
> > KVM currently crashes and burns on big-endian hosts, so don't allow it
> > to be selected until we've got that fixed.
> > 
> > Cc: Marc Zyngier <marc.zyngier@arm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> 
Thanks, applied to kvmarm/master.

-Christoffer
