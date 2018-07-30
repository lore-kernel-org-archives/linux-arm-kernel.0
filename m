From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jul 2018 23:59:22 +0100
Subject: [PATCH 0/6] rapidio: move Kconfig menu definition to subsystem
In-Reply-To: <20180730225035.28365-1-acolin@isi.edu>
References: <20180730225035.28365-1-acolin@isi.edu>
Message-ID: <20180730225921.GE17271@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I only have this message, and patches 5 and 6.  This is meaningless
for me to review - I can't tell what you've done as far as my comments
on your previous iteration.

Please arrange to _at least_ copy all patches the appropriate mailing
lists for the set with your complete patch set if you aren't going to
copy everyone on all patches in the set.

On Mon, Jul 30, 2018 at 06:50:28PM -0400, Alexei Colin wrote:
> In the current patchset, I took the approach of adding '|| PCI' to the
> depends in the subsystem. I did try the alterantive approach mentioned
> in the reviews for v1 of this patch, where the subsystem Kconfig does
> not add a '|| PCI' and each per-architecture Kconfig has to add a
> 'select HAS_RAPIDIO if PCI' and SoCs with IP blocks have to also add
> 'select HAS_RAPIDIO'. This works too but requires each architecture's
> Kconfig to add the line for RapidIO (whereas current approach does not
> require that involvement) and also may create a false impression that
> the dependency on PCI is strict.

... which means, as it stands, I've no idea what you actually came up
with for this.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
