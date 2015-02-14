From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 14 Feb 2015 17:49:52 +0100
Subject: [FOR DISCUSSION 0/8] Dove PMU support
In-Reply-To: <20150214152659.GI8656@n2100.arm.linux.org.uk>
References: <20150214152659.GI8656@n2100.arm.linux.org.uk>
Message-ID: <20150214164952.GF3213@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell

Thanks for posting these. Lets try to get them merged.

> There are a few things which are missing from this driver, such sa the
> DT binding documentation.  This will follow once people are happy with
> the first four patches, in particular where to locate the PMU driver
> in the kernel tree.  Currently, I have it in arch/arm/mach-dove, which
> is where the legacy Dove code lives, so it's not ideal.

Maybe time for a drivers/pmu? arch/arm/mach-dove is not good, we want
to be able to use this code from arch/arm/mach-mvebu.

   Andrew
