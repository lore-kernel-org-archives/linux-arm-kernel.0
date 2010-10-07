From: dwalker@codeaurora.org (Daniel Walker)
Date: Thu, 07 Oct 2010 14:58:33 -0700
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <20101007212707.GI7558@atomide.com>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<20101007212707.GI7558@atomide.com>
Message-ID: <1286488713.23836.112.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-10-07 at 14:27 -0700, Tony Lindgren wrote:

> Can you please pass the read and write functions to the driver
> in platform_data? We are already booting kernels with both
> ARMv6 and 7 compiled in.

What kind of situation did you want to use it in ? I was thinking about
how arm could have these functions in a header file, that way we
wouldn't duplicate in multiple places.

> Also, as it's a driver, other architectures may want to use it too.

I'm not sure if this model fits other architectures tho. They may not
have the same read/write/status sorts of stuff. Atleast I don't know
enough about other architectures jtags .

Daniel

-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
