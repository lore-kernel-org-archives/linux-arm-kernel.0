From: will.deacon@arm.com (Will Deacon)
Date: Wed, 31 Aug 2011 09:49:22 +0100
Subject: [PATCH] usb: ehci: make HC see up-to-date qh/qtd descriptor ASAP
In-Reply-To: <5484D075-A7DA-41B7-B8FA-9B6D72A23723@freescale.com>
References: <1314720193-26577-1-git-send-email-ming.lei@canonical.com>
	<1314722311.2344.64.camel@deneb.redhat.com>
	<20110830172642.GE3464@e102144-lin.cambridge.arm.com>
	<20110830174859.GA23098@kroah.com>
	<20110830175432.GG3464@e102144-lin.cambridge.arm.com>
	<5484D075-A7DA-41B7-B8FA-9B6D72A23723@freescale.com>
Message-ID: <20110831084922.GA8777@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2011 at 01:23:47AM +0100, Chen Peter-B29397 wrote:
> One question: why this write buffer issue did not happen at UP ARM V7 platform, whose dma buffer
> also uncache, but bufferable?

Which CPU was on this platform?

Will
