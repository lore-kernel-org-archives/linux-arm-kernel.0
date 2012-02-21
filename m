From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Feb 2012 10:16:30 +0000
Subject: [PATCH] ARM: at91: AIC and GPIO IRQ device tree initilization
In-Reply-To: <4F436C95.2040508@atmel.com>
References: <1329144189-4535-1-git-send-email-nicolas.ferre@atmel.com>
 <1329470878-14635-1-git-send-email-nicolas.ferre@atmel.com>
 <4F436C95.2040508@atmel.com>
Message-ID: <20120221101630.GI22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2012 at 11:06:13AM +0100, Nicolas Ferre wrote:
> Grant, Rob,
> 
> I would like to have some feedback from you so that we will be able to
> build our DT related work on top of this series.
> 
> If you agree with this work, we may need to send it through arm-soc git
> tree. This will require to establish a dependency with Grant's irqdomain
> branch: do you think that it is stable enough?

That depends whether Grant has fixed the x86 regression with
drivers/mfd/twl-core.c yet.
