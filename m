From: horms@verge.net.au (Simon Horman)
Date: Wed, 25 Jun 2014 17:00:00 +0900
Subject: [PATCH 0/9] ARM: shmobile: Move SoC-specific header files
In-Reply-To: <1403283189-21688-1-git-send-email-geert+renesas@glider.be>
References: <1403283189-21688-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20140625075959.GA10050@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 20, 2014 at 06:53:00PM +0200, Geert Uytterhoeven wrote:
> It's Friday afternoon, hence the ideal time for a no-brainer patch
> series to move the shmobile SoC-specific header files, so they can be
> included as "<soc>.h" instead of the old style <mach/<soc>.h>.
> 
> All build-tested. Multi-platform shmobile also boot-tested on
> r8a7791/koelsch.
> 
>   [1/9] ARM: shmobile: Move r7s72100.h
>   [2/9] ARM: shmobile: Move r8a73a4.h
>   [3/9] ARM: shmobile: Move r8a7740.h
>   [4/9] ARM: shmobile: Move r8a7778.h
>   [5/9] ARM: shmobile: Move r8a7779.h
>   [6/9] ARM: shmobile: Move r8a7790.h
>   [7/9] ARM: shmobile: Move r8a7791.h
>   [8/9] ARM: shmobile: Move sh7372.h
>   [9/9] ARM: shmobile: Move sh73a0.h

Thanks, I will queue these up.
