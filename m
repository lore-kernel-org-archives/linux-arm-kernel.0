From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 26 Nov 2013 14:50:52 +0100
Subject: ARM: add support to dump the kernel page tables
In-Reply-To: <20131024071600.GC16735@n2100.arm.linux.org.uk>
References: <20131024071600.GC16735@n2100.arm.linux.org.uk>
Message-ID: <20131126135052.GH28642@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Thu, Oct 24, 2013 at 08:16:00AM +0100, Russell King - ARM Linux wrote:
> +config ARM_PTDUMP
> +	bool "Export kernel pagetable layout ot userspace via debugfs"

just noticed while doing make oldconfig on next: You want to make
s/ot/to/ on that line.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
