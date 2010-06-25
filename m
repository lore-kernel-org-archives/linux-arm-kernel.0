From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 25 Jun 2010 14:30:53 -0400 (EDT)
Subject: [PATCH 3/4] [ARM] Introduce USE_DEFAULT_IO_H to use default
	definitions in asm/io.h
In-Reply-To: <1277451871-15319-4-git-send-email-eric.y.miao@gmail.com>
References: <1277451871-15319-1-git-send-email-eric.y.miao@gmail.com>
	<1277451871-15319-4-git-send-email-eric.y.miao@gmail.com>
Message-ID: <alpine.LFD.2.00.1006251429070.24097@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Jun 2010, Eric Miao wrote:

> From: Eric Miao <eric.miao@canonical.com>
> 
> For those machines that can just use the default definitions in asm/io.h,
> there is no need to have a machine specific mach/io.h. Introduce an config
> option for them.

I like this approach.  This allows us to transition specific machines 
gradually, and provide a clear set of conditions for multiple machine 
families to be eventually compilable together.


Nicolas
