From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 5 Jun 2012 10:44:36 +0800
Subject: v3.5-rc1 ARM PXA possible regression
In-Reply-To: <1338813305.51031.YahooMailClassic@web29018.mail.ird.yahoo.com>
References: <1338813305.51031.YahooMailClassic@web29018.mail.ird.yahoo.com>
Message-ID: <CAMPhdO9-+c5NipK7et5_W=ecNhojqkn5oUXe9_ifH1GmEJeXog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

There seems to be one other thread talking exactly about this,
possibly due to the change to printk(), and I believe it's not affecting
PXA only, but several other architectures as well.

On Mon, Jun 4, 2012 at 8:35 PM, Paul Parsons <lost.distance@yahoo.com> wrote:
> Linux 3.5.0-rc1 hangs on boot on my hx4700.
>
> Unfortunately it hangs before the kernel initializes the
> screen; since I possess no serial cable I cannot see the
> kernel messages.
>
> Linux 3.4.0 boots OK.
>
> Before I start bisecting is there an obvious change
> between v3.4 and v3.5-rc1 that I could be investigating?
> Since the screen is not initialized I suspect - but
> cannot prove - that the kernel hangs before the hx4700
> platform code is reached.
>
