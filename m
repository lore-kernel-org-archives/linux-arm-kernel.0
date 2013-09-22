From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 22 Sep 2013 14:00:56 +0100
Subject: [PATCH V3: Add Smp support for Allwinner A20. 1/3] Add smp
 support for Allwinner A20(sunxi 7i).
In-Reply-To: <1379852488-32147-2-git-send-email-cinifr@gmail.com>
References: <1379852488-32147-1-git-send-email-cinifr@gmail.com>
 <1379852488-32147-2-git-send-email-cinifr@gmail.com>
Message-ID: <20130922130056.GQ12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 22, 2013 at 08:21:26PM +0800, Fan Rong wrote:
> +.section ".text.head", "ax" ENTRY(sun7i_secondary_startup)
> +msr cpsr_fsxc,
> +#0xd3
> +b secondary_startup ENDPROC(sun7i_secondary_startup)

This looks like it's been messed up somehow.
