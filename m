From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Aug 2017 18:43:21 +0100
Subject: [PATCH v2 3/4] drm/bridge: dw-hdmi: add cec driver
In-Reply-To: <2270313.kliK1kl0Jl@avalon>
References: <20170731142906.GX31807@n2100.armlinux.org.uk>
 <20170802132730.GZ31807@n2100.armlinux.org.uk>
 <f9cddb0a-ed24-d5a4-c85e-ee803cebcfdd@xs4all.nl>
 <2270313.kliK1kl0Jl@avalon>
Message-ID: <20170802174321.GA31807@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 02, 2017 at 05:22:54PM +0300, Laurent Pinchart wrote:
> Then it should be even simpler. Instead of creating a separate platform device 
> for the DW HDMI CEC, we can just call the DW HDMI CEC driver init/cleanup 
> functions directly when the IP core implements CEC. When it doesn't, a 
> separate device will be described in DT (at least to my understanding, 
> otherwise where would it come from ?) and a separate driver would handle it.

Let me put this plainly, because my previous message seems not to have
the desired effect.

I am not changing this driver again until it is merged.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
