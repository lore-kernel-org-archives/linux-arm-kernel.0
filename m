From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 16 Jul 2010 14:40:38 -0400 (EDT)
Subject: [RFC PATCH] Kconfig: Enable Kconfig fragments to be used for
	defconfig
In-Reply-To: <20100716183028.GB26854@n2100.arm.linux.org.uk>
References: <20100713230352.6781.18644.stgit@angua>
	<1279296221.17878.66.camel@e102109-lin.cambridge.arm.com>
	<AANLkTinyFBTKYaryFANYheTuP-biJUws2x01NRNZPb4M@mail.gmail.com>
	<alpine.LFD.2.00.1007161406120.10598@xanadu.home>
	<20100716183028.GB26854@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1007161439240.10598@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Jul 2010, Russell King - ARM Linux wrote:

> On Fri, Jul 16, 2010 at 02:19:31PM -0400, Nicolas Pitre wrote:
> > For example, if I want CONFIG_MTD_CMDLINE_PARTS=y, the system may be 
> > smart enough to notice and automatically enable CONFIG_MTD and 
> > CONFIG_MTD_PARTITIONS without having to carry those in the defconfig.
> 
> How do you sort out something like this:
> 
> config FOO
> 	bool "Foo"
> 	depends on (A && B) || C

DOH.


Nicolas
