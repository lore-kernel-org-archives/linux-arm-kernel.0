From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 9 Jul 2014 10:42:42 +0100
Subject: [PATCH 0/2] arm: add early_ioremap support
In-Reply-To: <1404898792-4201-1-git-send-email-leif.lindholm@linaro.org>
References: <1404898792-4201-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20140709094242.GO21766@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 10:39:50AM +0100, Leif Lindholm wrote:
> early_ioremap()/early_memremap() create temporary virtual mappings
> in the fixmap region during boot time. Part of the support now exists
> in core code, but depends on the generic fixmap support.

Does this mean that the changes upon which this patch depends are
already merged in mainline, or are they queued in some other tree?

Thanks.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
