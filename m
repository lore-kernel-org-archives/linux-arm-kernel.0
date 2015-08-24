From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 24 Aug 2015 09:48:42 +0200
Subject: [PATCH v3 2/2] drivers: rtc: add xilinx zynqmp rtc driver
In-Reply-To: <20150824074310.GF13155@piout.net>
References: <1439978002-12157-1-git-send-email-suneel.garapati@xilinx.com>
 <1439978002-12157-2-git-send-email-suneel.garapati@xilinx.com>
 <20150824074310.GF13155@piout.net>
Message-ID: <55DACC5A.80707@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2015 09:43 AM, Alexandre Belloni wrote:
> On 19/08/2015 at 15:23:22 +0530, Suneel Garapati wrote :
>> adds support for RTC controller found on
>> Xilinx Zynq Ultrascale+ MPSoC platform.
>>
>> Signed-off-by: Suneel Garapati <suneel.garapati@xilinx.com>
>> ---
>> Changes v3 
>> - fix checkpatch errors 
>> - check time in secs arg against max sec val 
>> - order header files 
>> - use ptr_err_or_zero macro 
>> - use time64 variants 
>> Changes v2 
>> - change alm to alarm 
>> ---
>>  drivers/rtc/Kconfig      |   7 ++
>>  drivers/rtc/Makefile     |   1 +
>>  drivers/rtc/rtc-zynqmp.c | 279 +++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 287 insertions(+)
>>  create mode 100644 drivers/rtc/rtc-zynqmp.c
>>
> Applied, thanks.
> 

Thanks,
Michal
