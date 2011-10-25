From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Oct 2011 12:39:50 +0100
Subject: [PATCH 08/12] ARM: mach-ixp4xx: properly disable CPU idle call
In-Reply-To: <1319449801-12367-9-git-send-email-nico@fluxnic.net>
References: <1319449801-12367-1-git-send-email-nico@fluxnic.net>
	<1319449801-12367-9-git-send-email-nico@fluxnic.net>
Message-ID: <20111025113950.GB14840@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2011 at 05:49:57AM -0400, Nicolas Pitre wrote:
> +	/*
> +	 * ixp4xx does not implement the XScale PWRMODE register
> +	 * ixp4xx does not implement the XScale PWRMODE registerso it must not

Missing space between 'register' and 'so', otherwise this is fine.
