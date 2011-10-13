From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Oct 2011 15:56:15 +0100
Subject: [PATCH] arm: omap: Fix errors and warnings when building for
	one board
In-Reply-To: <1318517623-16066-1-git-send-email-premi@ti.com>
References: <1318517623-16066-1-git-send-email-premi@ti.com>
Message-ID: <20111013145615.GB22076@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 13, 2011 at 08:23:43PM +0530, Sanjeev Premi wrote:
> +#if defined(CONFIG_ARCH_OMAP4)

Please use #ifdef unless you're intending to expand the condition.
