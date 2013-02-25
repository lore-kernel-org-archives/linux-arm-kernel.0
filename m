From: gleb@redhat.com (Gleb Natapov)
Date: Mon, 25 Feb 2013 14:21:17 +0200
Subject: Fixing KVM/ARM breakage in mainline
In-Reply-To: <512B5693.4000608@arm.com>
References: <512B5693.4000608@arm.com>
Message-ID: <20130225122117.GE12299@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 25, 2013 at 12:18:27PM +0000, Marc Zyngier wrote:
> Russell, Marcelo, Gleb,
> 
> Commit 89f8833 (Merge tag 'kvm-3.9-1' of
> git://git.kernel.org/pub/scm/virt/kvm/kvm) broke KVM/ARM. Nothing
> fundamental, just annoying enough.
> 
> I've posted patches against next-20130215 some time ago:
> http://comments.gmane.org/gmane.comp.emulators.kvm.devel/105019
> 
> I've now created a branch based off mainline as of this morning, and
> containing these fixes:
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
> kvm-arm/core-3.9-rc1-fixes
> 
> Now the question is: who wants to merge this? The diffstat looks like this:
> 
I was going to merge it today.

--
			Gleb.
