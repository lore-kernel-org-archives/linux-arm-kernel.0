From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 25 May 2017 15:12:51 +0200
Subject: [PATCH v4 5/8] arm, arm64: factorize common cpu capacity default
 code
In-Reply-To: <20170420144316.15632-6-juri.lelli@arm.com>
References: <20170420144316.15632-1-juri.lelli@arm.com>
 <20170420144316.15632-6-juri.lelli@arm.com>
Message-ID: <20170525131251.GB16244@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 20, 2017 at 03:43:13PM +0100, Juri Lelli wrote:
> arm and arm64 share lot of code relative to parsing CPU capacity
> information from DT, using that information for appropriate scaling and
> exposing a sysfs interface for chaging such values at runtime.
> 
> Factorize such code in a common place (driver/base/arch_topology.c) in
> preparation for further additions.
> 
> Suggested-by: Will Deacon <will.deacon@arm.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Juri Lelli <juri.lelli@arm.com>
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
