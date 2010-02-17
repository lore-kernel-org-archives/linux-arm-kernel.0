From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 17 Feb 2010 13:19:56 -0000
Subject: [patch 00/12] arm: raw_spinlock annotations
Message-ID: <20100217125328.791176536@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Preempt-RT converts spinlocks to sleeping spinlocks, but some
spinlocks need to be kept as real spinlocks. In 2.6.33 we merged the
spinlock namespace cleanup which allows us to annotate those
locks. The lock type is change to raw_spinlock which is the same as a
common spinlock in !RT kernels.

The following series is a collection of lock annotations from the
preempt-rt tree. Please merge into 2.6.34.

Thanks,

	tglx
