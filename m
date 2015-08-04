From: slash.tmp@free.fr (Mason)
Date: Tue, 04 Aug 2015 15:41:22 +0200
Subject: IRQ setup on multicore systems (routing, balancing, etc)
Message-ID: <55C0C102.7050600@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello everyone,

I have a few very naive questions about interrupts.

How are interrupts set up on multicore systems?

If I write a device tree node for some peripheral, am I supposed
to specify which core each interrupt should be routed to?

On my system, there is a custom interrupt controller, but the ARM
chip also provides a Generic Interrupt Controller (GIC).

Am I supposed to use both, or can I use just the GIC?
(I suspect the answer is very platform-dependent.)

I've seen a lot of articles discussing interrupt "management"
on x86 (with APIC) but my search-foo is failing me for more
generic Linux "Howto set up". Are there good references?

I suppose I should take a look at these?
Documentation/devicetree/bindings/interrupt-controller/*
Documentation/devicetree/bindings/arm/gic.txt


For my own reference:

ARM Generic Interrupt Controller Architecture Specification v1.0 (IHI0048A)
Cortex-A9 MPCore (Revision: r3p0) Technical Reference Manual

Regards.
