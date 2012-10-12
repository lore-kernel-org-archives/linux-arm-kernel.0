From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Oct 2012 10:13:22 +0100
Subject: [RESEND PATCH 1/2] mmc: mmci: Fix incorrect handling of HW
 flow control for SDIO
In-Reply-To: <1349885000-22887-1-git-send-email-ulf.hansson@stericsson.com>
References: <1349885000-22887-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20121012091322.GC21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2012 at 06:03:19PM +0200, Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> For data writes <= 8 bytes, HW flow control was disabled but
> never re-enabled when the transfer was completed. This meant
> that a following read request would give buffer overrun errors.
> 
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Both look fine to me too.  Linus' has already said what needs to happen
with these two.  Thanks.
