From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 07 Mar 2013 02:28:57 +0300
Subject: [PATCH v4 0/3] R-Car SATA platform data
In-Reply-To: <20130301072501.GE14376@verge.net.au>
References: <201302272332.51650.sergei.shtylyov@cogentembedded.com>
 <20130301072501.GE14376@verge.net.au>
Message-ID: <5137D139.9010304@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/01/2013 10:25 AM, Simon Horman wrote:

>
>> Hello.
>>
>>     Here's the v4 of the set of now 3 patches (the driver itself has been merged
>> since) against the Simon Horman's renesas.git repo, 'next' branch:
>>
>> [1/3] ARM: mach-shmobile: r8a7779: SATA DT configuration
>> [2/3] ARM: mach-shmobile: r8a7779: add SATA support
>> [3/3] ARM: mach-shmobile: marzen: add SATA support
>>
>> Patch changes since the initial posting are reported in the individual patches.
> Thanks. I have refreshed the topic/r-car-sata branch of the renesas tree
> accordingly. That branch still contains a copy of the "Add Renesas R-Car
> on-chip 3Gbps SATA controller driver." but it should disappear once I rebase
> (e.g. on v3.9-rc1).

    I see you have finally merged my patches to your 'next' branch, thanks.
However, you've also merged Morimoto-san's patch to change from gic_spi()
to gic_iid(), and I thought I'd recast patch 2/3 to make it use 
gic_iid() too.
How do we do now, do I need to send a new patch to convert to gic_iid()?

WBR, Sergei
