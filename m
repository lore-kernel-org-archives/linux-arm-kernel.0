From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 Oct 2009 09:10:04 +0100
Subject: [PATCH 05/14] omap: Use ioremap in gpio.c
In-Reply-To: <20091016234104.2463.54276.stgit@localhost>
References: <20091016233624.2463.26653.stgit@localhost>
	<20091016234104.2463.54276.stgit@localhost>
Message-ID: <20091017081004.GA648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 16, 2009 at 04:41:04PM -0700, Tony Lindgren wrote:
> +	{ OMAP1_MPUIO_VBASE, 0, INT_MPUIO, IH_MPUIO_BASE,

That 0 should be NULL - it's a pointer.
