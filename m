From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 18 Jul 2010 10:00:56 +0100
Subject: [PATCH] ARM/nuc900: fix nuc900 touchscreen clk definition bug
In-Reply-To: <4C3FCBFF.50506@gmail.com>
References: <4C3FCBFF.50506@gmail.com>
Message-ID: <20100718090056.GC24707@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 11:03:27AM +0800, Wan ZongShun wrote:
> This patch is to fix nuc900 touchscreen clk definition bug,the .dev_id's
> name should be 'nuc900-ts', it should be the same to pdev.name. or else,
> the touchscreen driver will be not working well due to clock engine disabled.

Ok.
