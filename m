From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 20 Sep 2012 14:50:47 +0100
Subject: [PATCH] arm: introduce a DTS for Xen unprivileged virtual machines
In-Reply-To: <1348147826.26501.47.camel@zakaz.uk.xensource.com>
References: <1348076658-4511-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <1348135563.11116.94.camel@hornet>
 <alpine.DEB.2.02.1209201235450.29232@kaball.uk.xensource.com>
 <1348142133.11116.109.camel@hornet>
 <alpine.DEB.2.02.1209201308490.29232@kaball.uk.xensource.com>
 <505B0C00.5010003@arm.com> <1348147826.26501.47.camel@zakaz.uk.xensource.com>
Message-ID: <505B1F37.9040305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/09/12 14:30, Ian Campbell wrote:
> On Thu, 2012-09-20 at 13:28 +0100, Marc Zyngier wrote:
>> I think the important thing here is that the memory map is RS1. As this
>> is a (very limited) subset of a vexpress A15, it seems to make some sense.
> 
> Looking at arch/arm/boot/dts/vexpress-v2m-rs1.dtsi I don't think we
> provide anything which is on rs1 though.

The location of both GIC and memory are RS1 "compliant" (as in "they are
at the expected location").

	M.
-- 
Jazz is not dead. It just smells funny...
