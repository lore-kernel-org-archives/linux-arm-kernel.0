From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 20 Jun 2011 12:28:53 -0600
Subject: Pull request for Xilinx Zynq platform support
In-Reply-To: <1368783016.107284.1308592519852.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
References: <20110620175000.GH26089@n2100.arm.linux.org.uk>
	<1368783016.107284.1308592519852.JavaMail.root@sz0140a.emeryville.ca.mail.comcast.net>
Message-ID: <BANLkTikgLDPbGe=ZNSCaqeB_CPv-XwU+kQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yeah, don't mess with the output of git request-pull.  You should
include the whole thing in a pull req.

g.

On Mon, Jun 20, 2011 at 11:55 AM,  <johnlinn@comcast.net> wrote:
>> On Mon, Jun 20, 2011 at 05:28:00PM +0000, johnlinn at comcast.net wrote:
>> > ?Documentation/devicetree/bindings/arm/xilinx.txt | 7 +
>> > ?arch/arm/Kconfig | 14 +
>> > ?arch/arm/Makefile | 2 +
>> > ?arch/arm/boot/dts/zynq-ep107.dts | 52 ++++
>> > ?arch/arm/mach-zynq/Makefile | 6 +
>> > ?arch/arm/mach-zynq/Makefile.boot | 3 +
>> > ?arch/arm/mach-zynq/board_dt.c | 37 +++
>> > ?arch/arm/mach-zynq/common.c | 102 ++++++++
>> > ?arch/arm/mach-zynq/common.h | 29 ++
>> > ?arch/arm/mach-zynq/include/mach/clkdev.h | 32 +++
>> > ?arch/arm/mach-zynq/include/mach/debug-macro.S | 36 +++
>> > ?arch/arm/mach-zynq/include/mach/entry-macro.S | 30 +++
>> > ?arch/arm/mach-zynq/include/mach/hardware.h | 18 ++
>> > ?arch/arm/mach-zynq/include/mach/io.h | 33 +++
>> > ?arch/arm/mach-zynq/include/mach/irqs.h | 21 ++
>> > ?arch/arm/mach-zynq/include/mach/memory.h | 22 ++
>> > ?arch/arm/mach-zynq/include/mach/system.h | 28 ++
>> > ?arch/arm/mach-zynq/include/mach/timex.h | 23 ++
>> > ?arch/arm/mach-zynq/include/mach/uart.h | 25 ++
>> > ?arch/arm/mach-zynq/include/mach/uncompress.h | 51 ++++
>> > ?arch/arm/mach-zynq/include/mach/vmalloc.h | 20 ++
>> > ?arch/arm/mach-zynq/include/mach/zynq_soc.h | 48 ++++
>> > ?arch/arm/mach-zynq/timer.c | 298 ++++++++++++++++++++++
>> > ?arch/arm/mm/Kconfig
>>
>> Looks like the diffstat is manged as well.
>
> Thanks Russell, that was my mistake if your meaning it's not complete.
>
> I thought the rest wasn't needed. I'll include the entire diffstat on the
> next pull request also.
>
> -- John
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
