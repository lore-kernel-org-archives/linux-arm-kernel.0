From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Jul 2010 15:19:26 +0100
Subject: [PATCH v2 0/8] Initial implementation of kdump for ARM
In-Reply-To: <4C31E6C4.8030200@stericsson.com>
References: <20100611063605.GB11156@esdhcp04058.research.nokia.com>
	<4C2DE024.8060308@stericsson.com>
	<20100705082835.GA32178@gw.healthdatacare.com>
	<4C31AD62.6070805@stericsson.com>
	<20100705101852.GA19338@n2100.arm.linux.org.uk>
	<4C31B527.8060401@stericsson.com>
	<20100705135552.GB19338@n2100.arm.linux.org.uk>
	<4C31E6C4.8030200@stericsson.com>
Message-ID: <20100705141926.GA23860@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 05, 2010 at 04:05:56PM +0200, Per Fransson wrote:
> Well, I had another suggestion in my last mail.

Which is going to need per-CPU type support in order to achieve.  Do
we really want to implement relocate_new_kernel for each of the 24
CPU types which we currently support?
