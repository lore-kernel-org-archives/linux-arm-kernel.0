From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 11 Jan 2018 21:17:52 +0530
Subject: [PATCH v5 01/44] dt-bindings: clock: Add new bindings for TI
 Davinci PLL clocks
In-Reply-To: <CAHCN7xKORFriQ2Gjx85OsCUzHO-mavCQXLOzh5D3n4kEG=i-Yg@mail.gmail.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-2-git-send-email-david@lechnology.com>
 <ebd677dc-44a4-5053-2509-e3ee948ccf98@ti.com>
 <22409e49-5c14-4068-b137-7535afaf90d7@lechnology.com>
 <0f90b5f7-f21e-5f81-1154-9a815bbb786d@ti.com>
 <ba7fa842-cfc5-6f6f-f9bf-09c74ab08ec2@lechnology.com>
 <5aacc350-6236-2e4f-35bb-a681fc9d47e7@ti.com>
 <CAHCN7x+ZYezmEU_0mF=6_gF14DZxKnuDp1Cx=aC2=eN_QLNdJQ@mail.gmail.com>
 <fd162516-cddc-e857-ce60-2cd89303971e@lechnology.com>
 <CAHCN7xKORFriQ2Gjx85OsCUzHO-mavCQXLOzh5D3n4kEG=i-Yg@mail.gmail.com>
Message-ID: <14320e05-c6f7-fa2d-35cd-c01414c59f2f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 11 January 2018 06:15 PM, Adam Ford wrote:
> On Wed, Jan 10, 2018 at 8:50 PM, David Lechner <david@lechnology.com> wrote:
>> On 01/10/2018 04:24 PM, Adam Ford wrote:
>>>
>>>
>>> I am available tomorrow to build and test patches against the
>>> da850-evm.  I just need to know which version(s) to test.
>>
>>
>> Great. As per the cover letter:
>>
>> You can find a working branch with everything included in the
>> "common-clk-v5"
>> branch of https://github.com/dlech/ev3dev-kernel.git.
> 
> I wasn't sure if things had changed after some of the dialog about the
> bindings and device tree.
> 
> Here is my log with DEBUG_LL and CONFIG_EARLY_PRINTK set :
> 
> Starting kernel ...
> 
> Uncompressing Linux... done, booting the kernel.
> Booting Linux on physical CPU 0x0
> Linux version 4.15.0-rc4-g8564e0f (aford at ubuntu16) (gcc version 7.2.0
> (Buildroot 2017.11.1-00021-g7b43660)) #2 PREEMPT Thu Jan 11 06:35:29
> CST 2018
> CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=0005317f
> CPU: VIVT data cache, VIVT instruction cache
> OF: fdt: Machine model: DA850/AM1808/OMAP-L138 EVM
> Memory policy: Data cache writethrough
> cma: Reserved 16 MiB at 0xc2c00000
> DaVinci da850/omap-l138 variant 0x0
> random: fast init done
> Built 1 zonelists, mobility grouping on.  Total pages: 16256
> Kernel command line: console=ttyS2,115200n8 root=PARTUUID= rw

Pretty sure an actual UUID is missing here.

Thanks,
Sekhar
