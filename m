From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 08 Jul 2014 20:52:00 +0400
Subject: [PATCH A 01/12] net: fec: iMX6 FEC does not support half-duplex
 gigabit
In-Reply-To: <E1X4IF0-0004wh-0e@rmk-PC.arm.linux.org.uk>
References: <20140707232148.GG21766@n2100.arm.linux.org.uk>
 <E1X4IF0-0004wh-0e@rmk-PC.arm.linux.org.uk>
Message-ID: <53BC21B0.2020407@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 07/08/2014 03:22 AM, Russell King wrote:

> The iMX6 gigabit FEC does not support half-duplex gigabit operation.
> Phys attacked to the FEC may support this, and we currently do nothing

    s/attacked/attached/. Perhaps Dave can fix when applying...

> to disable this feature.  This may result in an invalid configuration.
> Mask out phy support for gigabit half-duplex operation.

> Acked-by: Fugang Duan <B38611@freescale.com>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

WBR, Sergei
