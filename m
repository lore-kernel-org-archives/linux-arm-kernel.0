From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 14 Apr 2011 17:33:39 -0400 (EDT)
Subject: [PATCH 1/2] ARM: the ADDR_NO_RANDOMIZE personality flag should
	be honored with mmap()
In-Reply-To: <4DA75D49.1050003@codeaurora.org>
References: <alpine.LFD.2.00.1104072249260.28032@xanadu.home>
	<4DA75D49.1050003@codeaurora.org>
Message-ID: <alpine.LFD.2.00.1104141727360.24613@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 14 Apr 2011, Stephen Boyd wrote:

> On 04/07/2011 07:51 PM, Nicolas Pitre wrote:
> > Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> > ---
> 
> Is this a stable candidate?

Maybe, but OTOH this is not critical.  You also need to have 
CONFIG_COMPAT_BRK=n before this makes any difference, and that option is 
enabled by default.


Nicolas
