From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Mon, 23 Jan 2017 08:18:35 +0000
Subject: [PATCHv4 3/5] pinctrl: mvebu: pinctrl driver for 98DX3236 SoC
References: <20170113091222.7132-1-chris.packham@alliedtelesis.co.nz>
 <20170113091222.7132-4-chris.packham@alliedtelesis.co.nz>
 <20170119100244.GX27312@n2100.armlinux.org.uk>
 <c873040cba1a4d5aa15dbaf3c5cc44e0@svr-chch-ex1.atlnz.lc>
Message-ID: <6eb30a9ec3cf4fc9971f33742f334980@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/01/17 10:10, Chris Packham wrote:
> On 19/01/17 23:03, Russell King - ARM Linux wrote:
>> On Fri, Jan 13, 2017 at 10:12:18PM +1300, Chris Packham wrote:
>>> +static struct mvebu_mpp_ctrl mv98dx3236_mpp_controls[] = {
>>> +	MPP_FUNC_CTRL(0, 32, NULL, armada_xp_mpp_ctrl),
>>> +};
>>
>> As Linus has taken my mvebu pinctrl series, this will need to be
>> changed to "mvebu_mmio_mpp_ctrl" rather than "armada_xp_mpp_ctrl"
>> when it's merged.
>>
>
> OK I was thinking about rebasing my series so maybe it's time.
>

I noticed the mvebu pinctrl series isn't in Linus's (Torvalds) tree. Is 
this on the cards for v4.10 or is it waiting for the next merge window? 
In other words should I send v5 or my series now or wait for this to be 
merged so I can rebase on top of it?
