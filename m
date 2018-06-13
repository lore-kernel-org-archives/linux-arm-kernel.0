From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 13 Jun 2018 22:07:20 +0300
Subject: [PATCH v2 0/5] Add R8A77980/Condor/V3HSK LVDS/HDMI support
In-Reply-To: <20180611081531.xaax5ouvffnarhq5@verge.net.au>
References: <390fabf0-4caf-1600-3780-1893207d94f7@cogentembedded.com>
 <4069170.tduNOXLj45@avalon> <20180611081531.xaax5ouvffnarhq5@verge.net.au>
Message-ID: <b6cb139a-b984-fdb3-2b06-30c630659776@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2018 11:15 AM, Simon Horman wrote:

>>> Here's the set of 5 patches against Simon Horman's 'renesas.git' repo's
>>> 'renesas-devel-20180604-v4.17' tag. We're adding the R8A77980 FCPVD/VSPD/
>>> DU/LVDS device nodes and then describing the LVDS decoder and HDMI encoder
>>> connected to the LVDS output. These patches depend on the Thine THC63LVD1024
>>> driver and the R8A77980 LVDS support patch in order to work, and R8A77980
>>> GPIO DT patches in order to apply/compile...
>>>
>>> [1/5] arm64: dts: renesas: r8a77980: add FCPVD support
>>> [2/5] arm64: dts: renesas: r8a77980: add VSPD support
>>> [3/5] arm64: dts: renesas: r8a77980: add DU support
>>> [4/5] arm64: dts: renesas: r8a77980: add LVDS support
>>
>> Based on the recent request of the ARM SoC maintainers to avoid a plethora of 
>> small patches, I think you can squash 1/5 to 4/5 all together.
> 
> Agreed.
> 
> Seregi could you please post a v2 with patches 1 - 4 squashed and the

   It's going to be v3 already. :-)

> register range for VSPD0 reduced to 0x5000? Thanks!

   More like increased. :-)
   Working on it...

>>> [5/5] arm64: dts: renesas: condor/v3hsk: add DU/LVDS/HDMI support

MBR, Sergei
