From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 7 Nov 2012 13:49:36 +0100
Subject: [PATCH v3] ARM: zynq: Allow UART1 to be used as DEBUG_LL console.
In-Reply-To: <20121105215410.GC1254@beefymiracle.amer.corp.natinst.com>
References: <1352151949-18319-1-git-send-email-nbowler@elliptictech.com>
 <20121105215410.GC1254@beefymiracle.amer.corp.natinst.com>
Message-ID: <CAHTX3dKV470iByg8MybxSch4i+r7_VxOWtxmeS94JapL4YpRYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/11/5 Josh Cartwright <josh.cartwright@ni.com>:
> On Mon, Nov 05, 2012 at 04:45:49PM -0500, Nick Bowler wrote:
>> The main UART on the Xilinx ZC702 board is UART1, located at address
>> e0001000.  Add a Kconfig option to select this device as the low-level
>> debugging port.  This allows the really early boot printouts to reach
>> the USB serial adaptor on this board.
>>
>> For consistency's sake, add a choice entry for UART0 even though it is
>> the the default if UART1 is not selected.
>>
>> Signed-off-by: Nick Bowler <nbowler@elliptictech.com>
>> Tested-by: Josh Cartwright <josh.cartwright@ni.com>
>> ---
>> Sorry all for the phenominal delay in sending this out.  Josh, I kept
>> your Tested-By since this version is Obviously Equivalent??? to v2...
>
> I re-tested again just in case and everything is good.


Thanks guys, Applied.

Michal
