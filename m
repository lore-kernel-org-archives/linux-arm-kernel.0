From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jul 2011 10:11:14 +0100
Subject: [PATCH v3 27/40] Subject: ARM: mm: proc-mohawk: Use the new
	processor struct macros
In-Reply-To: <1308851448-25139-28-git-send-email-dave.martin@linaro.org>
References: <1308851448-25139-1-git-send-email-dave.martin@linaro.org>
	<1308851448-25139-28-git-send-email-dave.martin@linaro.org>
Message-ID: <20110707091114.GJ8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 23, 2011 at 06:50:35PM +0100, Dave Martin wrote:
> NOTE: Even with this patch, this CPU is still broken due the lack
> of a suitable flush_icache_all function.

I assume that it now gets a build error rather than silently failing
at runtime?  If so, that's actually an improvement.
