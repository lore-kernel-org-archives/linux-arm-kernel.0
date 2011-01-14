From: alex@digriz.org.uk (Alexander Clouter)
Date: Fri, 14 Jan 2011 20:45:19 +0000
Subject: [PATCHv2] hwrng: add support for picoxcell TRNG
References: <20110114181609.GN2822@pulham.picochip.com>
	<1295030661-16364-1-git-send-email-jamie@jamieiles.com>
Message-ID: <v7p608-mqv.ln1@chipmunk.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In gmane.linux.ports.arm.kernel Jamie Iles <jamie@jamieiles.com> wrote:
>
> This driver adds support for the True Random Number Generator in
> the Picochip PC3X3 and later devices.
> 
> [snipped]
>
> +/*
> + * Take the random number generator out of reset and make sure the interrupts
> + * are masked. We shouldn't need to get large amounts of random bytes so just
> + * poll the status register. The hardware generates 32 bits every 320ns so we
> + * shouldn't have to wait long enough to warrant waiting for an IRQ.
> + */
>
timeriomem-rng?  Example of usage in 
arch/arm/mach-orion5x/ts78xx-setup.c.

Cheers

-- 
Alexander Clouter
.sigmonster says: The more I know men the more I like my horse.
