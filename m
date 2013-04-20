From: cdall@cs.columbia.edu (Christoffer Dall)
Date: Sat, 20 Apr 2013 09:59:20 -0700
Subject: KVM/ARM in next
Message-ID: <CAEDV+gK-84M+6zx_z1z48sNi5UiaELdsbz983tE7GOS25SnymA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

I'm maintaining the KVM/ARM implementation, which was merged during
the 3.9 merge window.

I'd like for you to pull changes from my kvm-arm-next branch at
git://github.com/columbia/linux-kvm-arm.git into linux-next.

The merge procedure for this tree is typically through the kvm tree,
but occasionally through Russell King's ARM tree, if there are
substantial changes to generic ARM code in there.

In case of problems please notify me and Marc Zyngier <marc.zyngier@arm.com>

Thanks,
-Christoffer
