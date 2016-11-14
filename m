From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Nov 2016 13:38:07 +0000
Subject: [PATCH 2/2] ARM: rename is_smp()
In-Reply-To: <878tsmchyc.fsf@free-electrons.com>
References: <E1c6GpW-0008DO-BD@rmk-PC.armlinux.org.uk>
 <878tsmchyc.fsf@free-electrons.com>
Message-ID: <20161114133806.GI1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 14, 2016 at 02:24:43PM +0100, Gregory CLEMENT wrote:
> Hi Russell,
> 
> Unless I am wrong I don't see any modification of the code behavior:
> just renaming the function and adding more comments. So it won't affect
> our platform and I am OK with the new name which also match our
> comments.

That's correct - it's an exercise in renaming to a clearer name.

Thanks for the ack.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
