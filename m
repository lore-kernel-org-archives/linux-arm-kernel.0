From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Feb 2014 18:03:36 +0000
Subject: [PATCH 2/2] ARM: dts: duovero-parlor: Add HDMI output
In-Reply-To: <1393261669-32039-3-git-send-email-florian.vaussard@epfl.ch>
References: <1393261669-32039-1-git-send-email-florian.vaussard@epfl.ch>
 <1393261669-32039-3-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <20140224180336.GU27282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 06:07:49PM +0100, Florian Vaussard wrote:
> +	hdmi0: connector at 0 {
> +		compatible = "hdmi-connector";

This looks way to generic a compatible string.  Are you sure it's
correct?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
