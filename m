From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Oct 2010 03:50:16 +0200
Subject: [PATCH v4] ARM: AT91: add board support for Pcontrol_G20
In-Reply-To: <20101014151451.GB23434@n2100.arm.linux.org.uk>
References: <1286466086.4306.41.camel@aspire.localdomain>
	<20101008123407.GB30252@game.jcrosoft.org>
	<1286550644.21584.34.camel@aspire.localdomain>
	<1286787761.7800.11.camel@aspire.localdomain>
	<1286792568.7800.19.camel@aspire.localdomain>
	<20101013131515.GC11087@game.jcrosoft.org>
	<1286979531.7165.9.camel@aspire.localdomain>
	<4CB71813.6060601@atmel.com>
	<20101014151451.GB23434@n2100.arm.linux.org.uk>
Message-ID: <20101015015016.GD11087@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:14 Thu 14 Oct     , Russell King - ARM Linux wrote:
> On Thu, Oct 14, 2010 at 04:47:47PM +0200, Nicolas Ferre wrote:
> > > diff --git a/arch/arm/configs/pcontrol_g20_defconfig b/arch/arm/configs/pcontrol_g20_defconfig
> > > new file mode 100644
> 
> Is it really necessary to have another platform specific defconfig rather
> than grouping it together with other similar platforms?
I'm working on it to merge the cpu and boards together hope to finish it
before the end of the merge window

Best Regards,
J.
