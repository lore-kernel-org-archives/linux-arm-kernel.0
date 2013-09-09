From: horms@verge.net.au (Simon Horman)
Date: Mon, 9 Sep 2013 09:11:21 +0900
Subject: [PATCH v2 0/4] Add Ether DT support for R8A7778/BOCK-W reference
 board
In-Reply-To: <201309070423.30672.sergei.shtylyov@cogentembedded.com>
References: <201309070423.30672.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130909001121.GC21921@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 07, 2013 at 04:23:29AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 4 patches against Simon Horman's 'renesas.git' repo,
> 'renesas-devel-20130906' tag. Here we add the Ether device tree support working
> on the R8A7778/BOCK-W reference board. The patchset requires the 'sh_eth' driver
> device tree support posted earlier in order to work.

These patches seem fine to me.
Magnus, Morimoto-san, do you have any feedback?

Assuming that is a run-time dependency I think I can go ahead
and queue these up for v3.13 once they are reviewed.

> 
> [1/4] ARM: shmobile: r8a7778: add Ether DT support
> [2/4] ARM: shmobile: r8a7778: add Ether clock for DT case
> [3/4] ARM: shmobile: bockw-reference: add Ether DT support
> [4/4] ARM: shmobile: BOCK-W reference: add Ether PFC settings
> 
> WBR, Sergei
> 
