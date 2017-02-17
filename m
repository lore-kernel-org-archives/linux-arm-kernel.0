From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Feb 2017 18:14:41 +0000
Subject: [PATCH] Documentation: Note QDF2400 SoC Erratum 44
In-Reply-To: <20170215215407.25854-1-cov@codeaurora.org>
References: <20170215215407.25854-1-cov@codeaurora.org>
Message-ID: <20170217181440.GP15431@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 04:54:07PM -0500, Christopher Covington wrote:
> The Qualcomm Datacenter Technologies QDF2400 family of SoCs contains a
> custom (non-PrimeCell) implementation of the SBSA UART. Occasionally the
> BUSY bit in the Flag Register gets stuck as 1, erratum 44 for both 2432v1
> and 2400v1 SoCs.Checking that the Transmit FIFO Empty (TXFE) bit is 0,
> instead of checking that the BUSY bit is 1, works around the issue. Note
> this in the customary location. To minimize conflicts, this documentation
> update is separate from the code changes, "tty: pl011: Work around QDF2400
> E44 stuck BUSY bit".
> 
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> Acked-by: Russell King <rmk+kernel@armlinux.org.uk>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Timur Tabi <timur@codeaurora.org>
> ---
> Documentation to go with https://patchwork.kernel.org/patch/9575103/

Please poke me when that goes into -next. I don't want to merge the doc
until the patch is queued too.

Thanks,

Will
