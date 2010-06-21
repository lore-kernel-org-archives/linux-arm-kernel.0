From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 21 Jun 2010 23:00:30 +0100
Subject: [RFC PATCH] smp: parallel smp boot option
In-Reply-To: <1277156422-9130-1-git-send-email-dwalker@codeaurora.org>
References: <1277156422-9130-1-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100621220030.GC13624@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 21, 2010 at 02:40:22PM -0700, Daniel Walker wrote:
> +#ifdef CONFIG_SMP_PARALLEL_START
> +	bl	__smp_secondary_spin
> +#endif

This seems to be half a patch - this doesn't exist.
