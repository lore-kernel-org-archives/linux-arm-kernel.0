From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Jun 2014 10:01:30 +0100
Subject: [PATCH] arm64: make CONFIG_ZONE_DMA user settable
In-Reply-To: <1403499924-11214-1-git-send-email-msalter@redhat.com>
References: <1403499924-11214-1-git-send-email-msalter@redhat.com>
Message-ID: <20140623090130.GG32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 23, 2014 at 01:05:24AM -0400, Mark Salter wrote:
> +config ZONE_DMA
> +	bool "32-bit DMA memory allocation"
> +	def_bool y

This should be either bool + default or def_bool.  Not bool + def_bool.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
