From: zlim.lnx@gmail.com (Zi Shen Lim)
Date: Mon, 8 Dec 2014 17:57:03 -0800
Subject: [RFC PATCH v2 1/4] arm64: defconfig: increase NR_CPUS range to
 2-128
In-Reply-To: <3519779.ILzEnWe9lP@wuerfel>
References: <1416605010-10442-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <1416605010-10442-2-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <3519779.ILzEnWe9lP@wuerfel>
Message-ID: <CAMDttNe33ie9vgyEn8GHz+8isadaDfXXUJcp5mQM-42_mx3Pbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Mon, Nov 24, 2014 at 3:53 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Saturday 22 November 2014 02:53:27 Ganapatrao Kulkarni wrote:
> > Raising the maximum limit to 128. This is needed for Cavium's
> > Thunder system that will have 96 cores on Multi-node system.
> >
> > Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
> >
>
> Could we please raise the compile-time limit to the highest number that
> you are able to boot successfully on some existing machine?
>
> There isn't much point in doubling this every few months.

Agreed. If we look back at [1], Mark Rutland has actually compiled and
boot-tested NR_CPUS=4096 on Juno.

[1] https://lkml.org/lkml/2014/9/8/537

>
>         Arnd
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
