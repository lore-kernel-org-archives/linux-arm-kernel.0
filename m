From: B29397@freescale.com (Chen Peter-B29397)
Date: Wed, 31 Aug 2011 12:33:29 +0000
Subject: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
In-Reply-To: <20110831084922.GA8777@e102144-lin.cambridge.arm.com>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>
	<1314722311.2344.64.camel@deneb.redhat.com>
	<20110830172642.GE3464@e102144-lin.cambridge.arm.com>
	<20110830174859.GA23098@kroah.com>
	<20110830175432.GG3464@e102144-lin.cambridge.arm.com>
	<5484D075-A7DA-41B7-B8FA-9B6D72A23723@freescale.com>
	<20110831084922.GA8777@e102144-lin.cambridge.arm.com>
Message-ID: <ED138203-5980-4D48-AC14-4784A199C89F@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Best Regard,
Peter Chen
 



On Aug 31, 2011, at 4:49 PM, Will Deacon wrote:

> On Wed, Aug 31, 2011 at 01:23:47AM +0100, Chen Peter-B29397 wrote:
>> One question: why this write buffer issue did not happen at UP ARM V7 platform, whose dma buffer
>> also uncache, but bufferable?
> 
> Which CPU was on this platform?

Cortex A8 UP system (freescale i.MX5x platform)
> 
> Will
> 
