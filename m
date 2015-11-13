From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Nov 2015 00:57:22 +0000
Subject: [BISECTED] v4.3-rc5: OMAP1 boot hang
In-Reply-To: <20151111214444.GF2260@blackmetal.musicnaut.iki.fi>
References: <20151013073046.GB7588@blackmetal.musicnaut.iki.fi>
 <20151111214444.GF2260@blackmetal.musicnaut.iki.fi>
Message-ID: <20151113005722.GQ32536@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2015 at 11:44:44PM +0200, Aaro Koskinen wrote:
> Hi,
> 
> Any suggestions how to debug this further? This happens also with v4.3
> final. Is the CPU_SW_DOMAIN_PAN supposed to work with this CPU?
> 
> I tried to disable various drivers (e.g. NAND, USB) and it still
> hangs... And it seems always at the same printk time stamp (roughly at
> 25 seconds).

No idea what so ever, and I have zero knowledge of this ARM925 thing -
never had one, and never seen any specs on it.  The weird thing is
that it's not producing any oops dump - I guess the kernel is totally
dead and unresponsive.  I'd ask if you have a heartbeat LED, but I'd
guess the answer will be that the hardware is too limited.

Any additional information you can give might help, but I wouldn't hold
out any hopes...

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
