From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jan 2017 10:02:44 +0000
Subject: [PATCHv4 3/5] pinctrl: mvebu: pinctrl driver for 98DX3236 SoC
In-Reply-To: <20170113091222.7132-4-chris.packham@alliedtelesis.co.nz>
References: <20170113091222.7132-1-chris.packham@alliedtelesis.co.nz>
 <20170113091222.7132-4-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170119100244.GX27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 13, 2017 at 10:12:18PM +1300, Chris Packham wrote:
> +static struct mvebu_mpp_ctrl mv98dx3236_mpp_controls[] = {
> +	MPP_FUNC_CTRL(0, 32, NULL, armada_xp_mpp_ctrl),
> +};

As Linus has taken my mvebu pinctrl series, this will need to be
changed to "mvebu_mmio_mpp_ctrl" rather than "armada_xp_mpp_ctrl"
when it's merged.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
