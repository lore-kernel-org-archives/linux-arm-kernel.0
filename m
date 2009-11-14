From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 14 Nov 2009 08:21:48 +0000
Subject: [PATCH] Update Samsung S5PC100 SoC support
In-Reply-To: <1258014122-18185-1-git-send-email-m.szyprowski@samsung.com>
References: <1258014122-18185-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20091114082148.GA18513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2009 at 09:21:44AM +0100, Marek Szyprowski wrote:
> This patch series updates Samsung S5PC100 SoC support.

Please go through all patches in this series looking for mach/gpio.h,
asm/io.h, asm/gpio.h include statements, and change them to their linux/
equivalents.  There's a number of such things in this patch set.
