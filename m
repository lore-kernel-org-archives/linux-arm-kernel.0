From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 29 Jun 2014 10:53:10 +0100
Subject: Your endian-ness fix patch
Message-ID: <20140629095310.GN32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I can't find it on the mailing list to reply to, so it's getting this
special message instead.  Please ensure that subject lines follow the
patch summary line on the mailing list so that patches - and more
importantly their CC list can be found.

I dropped it from the fixes branch because it depends on 8067/1, which
is merged in misc.  I thought I'd move 8067/1 to the fixes branch, and
while that allows your patch to be applied, it then means that my cleanup
of the vmlinux.lds mess needs to follow it too, and that definitely isn't
fixes material.

So, the result is I can't apply 8079/1 except to the misc branch, which
means it will have to wait for the next merge window.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
