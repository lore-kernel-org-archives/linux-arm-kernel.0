From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Sep 2009 14:38:12 +0100
Subject: Discussion request for new Samsung SoCs maintaining
In-Reply-To: <4A967FB0.8090502@billgatliff.com>
References: <24498970.196691251371216483.JavaMail.weblogic@epml12>
	<4A967FB0.8090502@billgatliff.com>
Message-ID: <20090901133812.GP19719@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 27, 2009 at 07:44:32AM -0500, Bill Gatliff wrote:
> I'm not sure I have any useful suggestion for this part.  It would have  
> been nice to have a "mach-a8" and "mach-arm11" for these situations,

A8 and ARM11 are CPU types and we already have a perfectly good
abstraction for these.  Should the Realview ARM11 end up in mach-arm11
and the Realview Cortex A8 end up in mach-a8?  Clearly, it's just
wrong.
