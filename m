From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 25 Jul 2013 19:14:16 +0400
Subject: [PATCH v2 1/3] ARM: shmobile: marzen: Switch to DT_MACHINE_START
In-Reply-To: <1374718423-24230-2-git-send-email-horms+renesas@verge.net.au>
References: <1374718423-24230-1-git-send-email-horms+renesas@verge.net.au>
 <1374718423-24230-2-git-send-email-horms+renesas@verge.net.au>
Message-ID: <51F140C8.8070802@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 25-07-2013 6:13, Simon Horman wrote:

> From: Magnus Damm <damm@opensource.se>

    Don't think it makes sense to keep Magnus as an author with so many of 
your added changes. But well, it's your decision...

> Convert the marzen board to use DT_MACHINE_START. With this in
> place all mach-shmobile boards use DT_MACHINE_START. Also, this
> makes it possible for the r8a7779 SMP code to use DT for CPUs.

> So appended DTB is the way forward on this board.

> Signed-off-by: Magnus Damm <damm@opensource.se>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

> v2 [Simon Horman]
> * Select USE_OF in Kconfig
> * Provide dt_compat in DT_MACHINE_START
> * Provide r8a7779-marzen dts

> v1 [Magnus Damm]
> ---
>   arch/arm/boot/dts/Makefile            |  1 +
>   arch/arm/boot/dts/r8a7779-marzen.dts  | 27 +++++++++++++++++++++++++++

    Perhaps arch/arm/boot/dts/ changes should be put into a separate patch?

WBR, Sergei
