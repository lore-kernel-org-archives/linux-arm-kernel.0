From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 12:10:40 +0100
Subject: [PATCH 10/24] msm: irq: rename existing entry-macro to
	entry-macro-vic
In-Reply-To: <1282712273-344-11-git-send-email-johlstei@codeaurora.org>
References: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
	<1282712273-344-11-git-send-email-johlstei@codeaurora.org>
Message-ID: <20100902111040.GW26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 24, 2010 at 09:57:39PM -0700, Jeff Ohlstein wrote:
> +#ifdef CONFIG_REQUEST_IPI
> +	cmp     \irqnr, #0
> +#else
> +	cmp     \irqnr, #15
> +#endif

What is CONFIG_REQUEST_IPI, and is it ever defined?
