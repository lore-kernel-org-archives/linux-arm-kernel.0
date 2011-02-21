From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Feb 2011 14:58:18 +0000
Subject: [PATCH v4 15/19] ARM: LPAE: use phys_addr_t instead of
	unsigned long for physical addresses
In-Reply-To: <1298299008.19814.20.camel@e102144-lin.cambridge.arm.com>
References: <1295891761-18366-1-git-send-email-catalin.marinas@arm.com>
	<1295891761-18366-16-git-send-email-catalin.marinas@arm.com>
	<20110219182631.GS29493@n2100.arm.linux.org.uk>
	<1298299008.19814.20.camel@e102144-lin.cambridge.arm.com>
Message-ID: <20110221145818.GQ14495@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 02:36:47PM +0000, Will Deacon wrote:
> Would you like me to submit an additional patch or are you happy merging
> this diff in with my ack?

The latter - I've already merged it and if you give an ack I'll add that.

Thanks.
