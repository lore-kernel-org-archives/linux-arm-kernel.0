From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Nov 2011 21:29:20 +0000
Subject: [ANNOUNCE] Xen port to Cortex-A15 / ARMv7 with virt extensions
In-Reply-To: <alpine.DEB.2.00.1111281009090.31179@kaball-desktop>
References: <alpine.DEB.2.00.1111281009090.31179@kaball-desktop>
Message-ID: <201111292129.20444.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 November 2011, Stefano Stabellini wrote:
> Hi all,
> a few weeks ago I (and a few others) started hacking on a
> proof-of-concept hypervisor port to Cortex-A15 which uses and requires
> ARMv7 virtualization extensions. The intention of this work was to find
> out how to best support ARM v7+ on Xen. See
> http://old-list-archives.xen.org/archives/html/xen-arm/2011-09/msg00013.html
> for more details. 
> 
> I am pleased to announce that significant progress has been made, and
> that we now have a nascent Xen port for Cortex-A15. The port is based on
> xen-unstable (HG CS 8d6edc3d26d2) and written from scratch exploiting
> the latest virtualization, LPAE, GIC and generic timer support in
> hardware.

Very nice!

Do you have a pointer to the kernel sources for the Linux guest?
Since Xen and KVM are both in an early working state right now,
it would be very nice if we could agree on the guest model to make
sure that it's always possible to run the same kernel in both
(and potentially other future) hypervisors without modifications.

	Arnd
