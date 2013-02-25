From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 25 Feb 2013 17:08:19 +0400
Subject: [PATCH v2 0/4] R-Car SATA driver and platform data
In-Reply-To: <20130219034210.GA7701@verge.net.au>
References: <201302182327.46930.sergei.shtylyov@cogentembedded.com>
 <20130219034210.GA7701@verge.net.au>
Message-ID: <512B6243.9060808@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 19-02-2013 7:42, Simon Horman wrote:

>>     Here's the v2 of the set of 4 patches against the Simon Horman's renesas.git
>> repo, 'next' branch:

>> [1/4] libata: add R-Car SATA driver
>> [2/4] ARM: mach-shmobile: r8a7779: SATA DT configuration
>> [3/4] ARM: mach-shmobile: r8a7779: add SATA support
>> [4/4] ARM: mach-shmobile: marzen: add SATA support

>> Patch 1 also applies to the 'upstream' branch of Jeff Garzik's libata-dev.git
>> repo.

>> Patch changes since the initial posting are reported in the individual patches.

> Thanks, I have updated topic/r-car-sata and verified
> that the SATA driver is successfully initialised for both
> non-DT and DT boot.

    The SATA driver have been already merged by Linus:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h=163cf81d266f017d718ef786fbbb6b2513ce7ec3

Can we merge the rest of the patches in this merge window?

WBR, Sergei
