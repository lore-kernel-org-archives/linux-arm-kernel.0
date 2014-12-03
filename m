From: orsonzhai@gmail.com (Orson Zhai)
Date: Wed, 03 Dec 2014 10:35:45 +0800
Subject: [PATCH v3 3/5] arm64: dts: Add support for Spreadtrum SC9836
 SoC in dts and Makefile
In-Reply-To: <20141127115042.GE857@leverpostej>
References: <Sharkl64-v3>
 <1416917818-10506-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1416917818-10506-4-git-send-email-chunyan.zhang@spreadtrum.com>
 <20141127115042.GE857@leverpostej>
Message-ID: <547E7701.7030203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mark,

On 2014?11?27? 19:50, Mark Rutland wrote:
>> >+       clocks {
>> >+               clk26mhz: clk26mhz {
>> >+                       compatible = "fixed-clock";
>> >+                       #clock-cells = <0>;
>> >+                       clock-frequency = <26000000>;
>> >+               };
>> >+       };
> Get rid of the "clocks" container node. There's no need for it.
We are going to add more clk nodes when relative device drivers being 
committed.
Could we reserve clocks{} here for future use?
Or we remove it now and add it back when needed?

Thanks,
Orson
> Thanks,
> Mark.
