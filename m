From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 10 Apr 2014 12:11:58 +0200
Subject: [RFC PATCH v2] edac: synopsys: Added EDAC support for zynq ddr
 ecc controller
In-Reply-To: <20140410100542.GH29093@pd.tnic>
References: <1220b715-6fc2-42ed-8393-b9859fc0deb9@TX2EHSMHS021.ehs.local>
 <20140408204047.GQ30077@pd.tnic> <534633C0.9090905@monstr.eu>
 <20140410092144.GD29093@pd.tnic>
 <5e0042b6-f169-4025-8fd7-9d70c2ed0cf6@AM1EHSMHS012.ehs.local>
 <20140410100047.GG29093@pd.tnic> <20140410100542.GH29093@pd.tnic>
Message-ID: <2508260c-5ae5-4ff5-97a9-248470c062af@CH1EHSMHS012.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2014 12:05 PM, Borislav Petkov wrote:
> On Thu, Apr 10, 2014 at 12:00:47PM +0200, Borislav Petkov wrote:
>> Then you'll have to check whether edac can even stomach more than one
>> drivers in parallel. TTBOMK, no one has ever done this so far... Yadda
>> yadda.
> 
> Alternatively, you could put together a single edac driver which
> contains both zynq and L2 functionality.

That's seems to more problematic because we just don't know what our
customers will do and what combinations they will use.

Thanks,
Michal
