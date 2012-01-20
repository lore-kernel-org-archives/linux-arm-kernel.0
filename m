From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 20 Jan 2012 13:03:10 +0000
Subject: [PATCH] ARM: ux500: Initialize irq affinity
In-Reply-To: <1327064356-3603-1-git-send-email-per.xx.fransson@stericsson.com>
References: <1327064356-3603-1-git-send-email-per.xx.fransson@stericsson.com>
Message-ID: <20120120130310.GO1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 20, 2012 at 01:59:16PM +0100, Per Fransson wrote:
> Use irq_set_affinity() to initialize the kernel view of irq affinity
> when programming the GIC registers.

Why is this necessary?  And if it is necessary, why do you think it
should be ux500 specific?
