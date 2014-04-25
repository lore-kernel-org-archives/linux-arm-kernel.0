From: horms@verge.net.au (Simon Horman)
Date: Fri, 25 Apr 2014 10:31:17 +0900
Subject: [PATCH 0/2] Add R8A7791/Henninger board DT support
In-Reply-To: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
Message-ID: <20140425013107.GD12641@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 25, 2014 at 02:39:38AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 2 patches against Simon Horman's 'renesas.git' repo,
> 'renesas-devel-v3.15-rc2-20140421' tag. Here we add support for the R8A7791-
> based Henninger board AKA R-Car M2 Low Cost Development Platform (M2-LCDP);
> this board is very like already supported Koelsch board, although some
> differences do exist. The board can be booted using the device tree only, with
> no pre-requisites...
> 
> [1/2] ARM: shmobile: Henninger: initial device tree
> [2/2] ARM: shmobile: Henninger: add Ether DT support

Thanks, I have queued these up.

N.B: I do not currently have access to a Henninger board.
     So unlike other boards for ARM-based Renesas SoCs that are present in
     mainline I will not be boot-testing patches for this board.
