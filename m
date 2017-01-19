From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 19 Jan 2017 21:10:39 +0000
Subject: [PATCHv4 3/5] pinctrl: mvebu: pinctrl driver for 98DX3236 SoC
References: <20170113091222.7132-1-chris.packham@alliedtelesis.co.nz>
 <20170113091222.7132-4-chris.packham@alliedtelesis.co.nz>
 <20170119100244.GX27312@n2100.armlinux.org.uk>
Message-ID: <c873040cba1a4d5aa15dbaf3c5cc44e0@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/01/17 23:03, Russell King - ARM Linux wrote:
> On Fri, Jan 13, 2017 at 10:12:18PM +1300, Chris Packham wrote:
>> +static struct mvebu_mpp_ctrl mv98dx3236_mpp_controls[] = {
>> +	MPP_FUNC_CTRL(0, 32, NULL, armada_xp_mpp_ctrl),
>> +};
>
> As Linus has taken my mvebu pinctrl series, this will need to be
> changed to "mvebu_mmio_mpp_ctrl" rather than "armada_xp_mpp_ctrl"
> when it's merged.
>

OK I was thinking about rebasing my series so maybe it's time.
