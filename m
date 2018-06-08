From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 8 Jun 2018 11:51:17 +0300
Subject: [PATCH v2 0/5] Add R8A77980/Condor/V3HSK LVDS/HDMI support
In-Reply-To: <20180608082125.tjnd6jayecv26csv@verge.net.au>
References: <390fabf0-4caf-1600-3780-1893207d94f7@cogentembedded.com>
 <20180608082125.tjnd6jayecv26csv@verge.net.au>
Message-ID: <12b910a6-d7c6-8d8a-07f2-989e26a010e0@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/8/2018 11:21 AM, Simon Horman wrote:

>> Here's the set of 5 patches against Simon Horman's 'renesas.git' repo's
>> 'renesas-devel-20180604-v4.17' tag. We're adding the R8A77980 FCPVD/VSPD/
>> DU/LVDS device nodes and then describing the LVDS decoder and HDMI encoder
>> connected to the LVDS output. These patches depend on the Thine THC63LVD1024
>> driver and the R8A77980 LVDS support patch in order to work, and R8A77980 GPIO
>> DT patches in order to apply/compile...
>>
>> [1/5] arm64: dts: renesas: r8a77980: add FCPVD support
>> [2/5] arm64: dts: renesas: r8a77980: add VSPD support
>> [3/5] arm64: dts: renesas: r8a77980: add DU support
>> [4/5] arm64: dts: renesas: r8a77980: add LVDS support
>> [5/5] arm64: dts: renesas: condor/v3hsk: add DU/LVDS/HDMI support
> 
> Sergei,
> 
> what are the changes in this series between v1 and v2?

    See patch #5. I've added the V3HSK DT update there...

MBR, Sergei
