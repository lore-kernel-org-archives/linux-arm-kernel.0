From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Oct 2015 11:23:13 +0100
Subject: PING: [PATCH v4 TRIVIAL 1/2] ARM: Enable GICv2m on 32-bit virt
 machine
In-Reply-To: <017801d100dc$77fe3a90$67faafb0$@samsung.com>
References: <017801d100dc$77fe3a90$67faafb0$@samsung.com>
Message-ID: <20151007102313.GG21513@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 11:45:06AM +0300, Pavel Fedin wrote:
>  Hello! I have retested this on 4.3rc3, everything is fine. 2/2 has
> been already picked up, so this is the only bit left.

Sorry, I've no idea if this is the right thing to do.

I know we have MSI-using platforms working on 32-bit ARM at the moment,
which brings up the question about msi.h in your patch, and what are
the implications for the existing MSI using platforms of having
PCI_MSI_IRQ_DOMAIN enabled in a multiplatform kernel.

I don't know enough to be able to merge this patch, and there's not
enough information in the commit message either.  Plus, with the lack
of acks from people in ARM, I'm very reluctant to take this (I don't
know whether the original patch got any, it's fallen out of my mailbox.)

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
