From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 17 Nov 2009 23:53:11 +0000
Subject: [PATCH v3] Update Samsung S5PC100 SoC support
In-Reply-To: <1258443684-19525-1-git-send-email-m.szyprowski@samsung.com>
References: <1258443684-19525-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20091117235311.GZ23772@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2009 at 08:41:10AM +0100, Marek Szyprowski wrote:
> Hello,
> 
> This patch series updates Samsung S5PC100 SoC support. S5PC100 platform
> core has been extended with new clocks hierarchy implementation, gpio lib,
> support for external and gpio interrupts and some basics of power
> management (cpu idle and system reset). Also platform helpers for
> s3c framebuffer, i2c and hsmmc drivers has been added.
> 
> All these patches has been tested on SMDKC100 board.

Hi, next time, --no-chain-reply-to please so that we don't end up
with messages wandering off the edge of the screen.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
