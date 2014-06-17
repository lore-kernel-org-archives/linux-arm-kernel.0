From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Jun 2014 14:40:16 +0100
Subject: [PATCH 0/2] DT updates for Cubox-i
Message-ID: <20140617134016.GK23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

These are two updates to the Cubox-i which I'd prefer to get into -rc.
They were omitted from the merge window because their dependent changes
were not merged, but have now been merged.

The only real functional change for the Cubox-i in this set is that it
is now possible to control the front panel LED.  The other patch is
solely about moving some DT configuration to where it belongs.

Can we please get these in?

Thanks.

 arch/arm/boot/dts/imx6dl-hummingboard.dts | 10 ++++++++++
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi    | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-microsom.dtsi   | 13 -------------
 3 files changed, 37 insertions(+), 13 deletions(-)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
