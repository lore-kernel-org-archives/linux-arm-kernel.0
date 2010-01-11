From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Jan 2010 10:02:54 +0000
Subject: [PATCH 3/3] ARM: SAMSUNG: Add idle support
In-Reply-To: <1263203072-29282-1-git-send-email-kgene.kim@samsung.com>
References: <1263203072-29282-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100111100253.GA30556@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 06:44:32PM +0900, Kukjin Kim wrote:
> This patch adds common idle functionality for all Samsung SoC's.

NAK.  Please use the existing support already provided.  There's no point
in double-indirection - it just makes the code harder to follow.

Just set pm_idle to your idle function.
