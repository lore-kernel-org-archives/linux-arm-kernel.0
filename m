From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 17 Sep 2011 16:05:22 +0100
Subject: [PATCH 01/19] ARM: sort the meminfo array earlier
In-Reply-To: <1316156850-31013-2-git-send-email-nico@fluxnic.net>
References: <1316156850-31013-1-git-send-email-nico@fluxnic.net>
	<1316156850-31013-2-git-send-email-nico@fluxnic.net>
Message-ID: <20110917150522.GI16381@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2011 at 03:07:12AM -0400, Nicolas Pitre wrote:
> From: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> The meminfo array has to be sorted before sanity_check_meminfo() can work
> properly.

This is unrelated to the patch series, so it should be separate from the
series.  I don't see anything in the series depending on it.
