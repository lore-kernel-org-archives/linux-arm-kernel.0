From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 28 Jun 2014 04:17:09 +0400
Subject: [PATCH v2 0/3] Add R8A7791/Koelsch/Henninger board PCI DT support
In-Reply-To: <20140627235939.GC27128@verge.net.au>
References: <201405200148.28683.sergei.shtylyov@cogentembedded.com>
 <537B9CF0.8020000@cogentembedded.com> <20140627235939.GC27128@verge.net.au>
Message-ID: <53AE0985.9020604@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 06/28/2014 03:59 AM, Simon Horman wrote:

>>>     Here's the set of 3 patches against Simon Horman's 'renesas.git' repo,
>>> 'renesas-devel-v3.15-rc5-20140517' tag. Here we add internal PCI support for
>>> the R8A7791-based Koelsch and Henninger boards for the sake of getting USB
>>> EHCI/OHCI working...

>>     Forgot to mention that it depends on the internal PCI bridge device tree
>> support reposted just before these patches...

>>> [1/3] ARM: shmobile: r8a7791: add internal PCI bridge nodes
>>> [2/3] ARM: shmobile: koelsch: enable internal PCI
>>> [3/3] ARM: shmobile: henninger: enable internal PCI

> Thanks, please repost these patches when the device tree support

    Where did you get that old stuff? The current version of this patchset is 
4, not 2!

WBR, Sergei
