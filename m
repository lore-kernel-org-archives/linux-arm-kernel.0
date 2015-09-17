From: slash.tmp@free.fr (Mason)
Date: Thu, 17 Sep 2015 17:55:22 +0200
Subject: Recent GIC v1 patch
Message-ID: <55FAE26A.9040609@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas, Marc,

Mans pointed me to a recent patch of yours.
irqchip/gic: Use IRQD_FORWARDED_TO_VCPU flag
Get rid of the handler_data abuse.

I'm using a Cortex A9 based SoC. The platform's interrupt
controller is cascaded into the GIC. I've been trying to
get this to work for two weeks with no success.

Details can be found here:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/440327

Do you think your patch my help with my situation?

Do you have any idea what might causing the problem?

Regards.
