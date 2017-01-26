From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 26 Jan 2017 20:24:46 +0000
Subject: [PATCHv3 4/5] arm: mvebu: Add device tree for 98DX3236 SoCs
References: <20170105033641.6212-1-chris.packham@alliedtelesis.co.nz>
 <20170106041517.9589-1-chris.packham@alliedtelesis.co.nz>
 <20170106041517.9589-5-chris.packham@alliedtelesis.co.nz>
 <87inp1zwlg.fsf@free-electrons.com>
Message-ID: <cca41061129f4378bfd41a66c8eb71e1@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/01/17 04:10, Gregory CLEMENT wrote:
>> +		internal-regs {

[snip]

>> +
>> +		dfx-registers {
> node label
>

[snip]

>> +		switch {
> node label
>

These are peers to the internal-regs, i.e. parts of the SoC with 
mappable windows in the address space. Do they really need a label? 
Their subnodes absolutely need (and have) labels.
