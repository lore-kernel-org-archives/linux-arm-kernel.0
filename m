From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 18 Jul 2010 10:00:09 +0100
Subject: [PATCH] ARM/nuc900: re-organize the nuc900 lcd arch platform
	data setting
In-Reply-To: <4C400377.3020408@gmail.com>
References: <4C400377.3020408@gmail.com>
Message-ID: <20100718090009.GB24707@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 16, 2010 at 03:00:07PM +0800, Wan ZongShun wrote:
> The patch re-organizes the nuc900 lcd arch platform data,
> remove the lcd platform data setting from nuc950.c to dev.c
> 
> It can maximize the share codes between nuc900 series MCUs.

Ok.
