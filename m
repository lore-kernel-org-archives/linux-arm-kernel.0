From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Feb 2013 18:33:31 +0000
Subject: [PATCH 1/9] ARM: arch_timer: include linux/errno.h
In-Reply-To: <20130215102618.GJ25537@e106331-lin.cambridge.arm.com>
References: <1360882071-4072668-1-git-send-email-arnd@arndb.de>
 <1360882071-4072668-2-git-send-email-arnd@arndb.de>
 <20130215102618.GJ25537@e106331-lin.cambridge.arm.com>
Message-ID: <201302151833.31646.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 February 2013, Mark Rutland wrote:
> As with Stephen Warren's fix [1], this looks right to me. Stephen's has the
> added benefit of keeping the includes ordered.
> 
> For either version:
> 
> Acked-By: Mark Rutland <mark.rutland@arm.com>

Applied to the next/virt branch now.

	Arnd
