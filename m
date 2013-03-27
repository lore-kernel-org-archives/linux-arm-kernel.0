From: monstr@monstr.eu (Michal Simek)
Date: Wed, 27 Mar 2013 11:47:40 +0100
Subject: [PATCH v2 04/10] arm: zynq: Load scu baseaddress at run time
In-Reply-To: <201303271045.03736.arnd@arndb.de>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
 <201303271000.47614.arnd@arndb.de>
 <CAHTX3d+J370kD=1Eeuo_srKCngFizuYV=HtmgYsHfXvG80O01w@mail.gmail.com>
 <201303271045.03736.arnd@arndb.de>
Message-ID: <CAHTX3dK_K7fEUi7tOyi9ExCBxSc-uOPTmvi9D9r670JaJ9iHdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/27 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 27 March 2013, Michal Simek wrote:
>> BTW: Have you added to zero day testing system arm multi platform
>> or is there any arm multi platform config which developer should run
>> to be sure that armv7 code can be compiled for armv6 and also
>> that there is no problem with symbols?
>
> I'm only occasionally doing build tested right now, not all the time.

What about to provide this config to Fengguang to add this to zero day testing
system which will check this all the time?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
