From: tony@atomide.com (Tony Lindgren)
Date: Fri, 8 Oct 2010 13:36:40 -0700
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <1286488713.23836.112.camel@c-dwalke-linux.qualcomm.com>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<20101007212707.GI7558@atomide.com>
	<1286488713.23836.112.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20101008203640.GO7558@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Daniel Walker <dwalker@codeaurora.org> [101007 14:50]:
> On Thu, 2010-10-07 at 14:27 -0700, Tony Lindgren wrote:
> 
> > Can you please pass the read and write functions to the driver
> > in platform_data? We are already booting kernels with both
> > ARMv6 and 7 compiled in.
> 
> What kind of situation did you want to use it in ? I was thinking about
> how arm could have these functions in a header file, that way we
> wouldn't duplicate in multiple places.

Well with ifdef else it's still either or for kernels that have
ARMv6 and 7 both compiled in. It's best to initialize those
functions dynamically.

Regards,

Tony
