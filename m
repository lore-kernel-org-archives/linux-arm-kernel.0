From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 25 Oct 2015 21:53:15 +0100
Subject: [PATCH v4 0/5] mtd: pxa3xx_nand: rework the timing setup
In-Reply-To: <1445416144-9194-1-git-send-email-antoine.tenart@free-electrons.com>
 (Antoine Tenart's message of "Wed, 21 Oct 2015 10:28:59 +0200")
References: <1445416144-9194-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <877fmallfo.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Antoine Tenart <antoine.tenart@free-electrons.com> writes:

> Hello,
>
> Let's try one more time to get this merged.
>
> This series was part of a bigger one[1], which was split into smaller
> ones as asked by Ezequiel[2]. When we take this into account this is
> v9; with a v1 sent in January, 9 months ago.
>
> Another series, introducing the Berlin nand support, depends on this.
>
> The aim here is to use the nand framework to setup the timings,
> while keeping the old in-driver way of configuration timings for
> compatibility reasons.
>
> You can find the series at:
> https://github.com/atenart/linux.git berlin/4.3/nand-timings

Hi Antoine,

I tested this serie once on my zylonite board, with both keep_config and no
keep_config setups. Both do work fine.

Cheers.

--
Robert
