From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Mar 2015 21:08:17 +0000
Subject: [PATCH] ARM: amba: Increase number of IRQs
In-Reply-To: <1426529962-2204-1-git-send-email-sbranden@broadcom.com>
References: <sbranden@broadcom.com>
 <1426529962-2204-1-git-send-email-sbranden@broadcom.com>
Message-ID: <20150316210817.GQ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 16, 2015 at 11:19:22AM -0700, Scott Branden wrote:
> The current AMBA bus only allows up to 9 IRQs per device. This is
> incorrect, as in peripherals like PL330 can have up to 32 IRQs.
> Increase AMBA_NR_IRQS from 9 to 32.

I'm quite certain that 32 will also be "incorrect" at some point in the
future, so let's not use such language.  Let's make this more neutral
and say "This does not suit peripherals like the PL330 which can have
up to 32 IRQs."

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
