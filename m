From: gleb@redhat.com (Gleb Natapov)
Date: Thu, 24 Jan 2013 19:14:33 +0200
Subject: [PATCH v6 00/15] KVM/ARM Implementation
In-Reply-To: <20130124162627.GE18233@arm.com>
References: <20130116175716.29147.15348.stgit@ubuntu>
 <20130124162627.GE18233@arm.com>
Message-ID: <20130124171432.GC18762@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 24, 2013 at 04:26:28PM +0000, Catalin Marinas wrote:
> Hi Christoffer,
> 
> On Wed, Jan 16, 2013 at 05:57:19PM +0000, Christoffer Dall wrote:
> > The following series implements KVM support for ARM processors,
> > specifically on the Cortex A-15 platform.
> 
> I went through the KVM patches (just this series, not the vgic or
> timers) and apart from a few minor clean-up issues (which can be done
> later as an additional patch) they look fine to me.
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Same here. Reviewed the patch series from KVM perspective. There are
improvements that can be done to vcpu run loop, but nothing that should
prevent this series from going in.

Reviewed-by: Gleb Natapov <gleb@redhat.com>
 
--
			Gleb.
