From: monstr@monstr.eu (Michal Simek)
Date: Wed, 27 Mar 2013 14:31:20 +0100
Subject: [PATCH v2 05/10] arm: zynq: Move slcr initialization to separate
 file
In-Reply-To: <5152EDB2.6080408@balister.org>
References: <1364319822-5504-1-git-send-email-michal.simek@xilinx.com>
 <dc278dadd3614b4736f43a09b9c5d7ccd2232403.1364319776.git.michal.simek@xilinx.com>
 <5152EDB2.6080408@balister.org>
Message-ID: <CAHTX3dLbivuPfayFdWBTPwMPCOhcwKodHO-Gu4Ph5cRgZXkWFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philip,

2013/3/27 Philip Balister <philip@balister.org>:
> On 03/26/2013 01:43 PM, Michal Simek wrote:
>>
>> Create separate slcr driver instead of pollute common code.
>
>
> Nitpicking: A native speaker would say "polluting common code".

Feel free to check my english. :-)

M


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
