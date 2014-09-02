From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 2 Sep 2014 10:20:04 -0300
Subject: mx28 battery charger support
In-Reply-To: <20140902103913.GA9417@piout.net>
References: <20140902103913.GA9417@piout.net>
Message-ID: <CAOMZO5BNNBzJA0Q-Ls-c7ch-LXEhkuYxFwxJk72d7ZAL5mwJOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

On Tue, Sep 2, 2014 at 7:39 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> Hi,
>
> I'm having a look at the battery charger on i.mx28. Is there any
> mainline driver or any attempt at mainlining a driver? The IP is not
> documented in the i.MX28 Applications Processor Reference Manual but
> there is an existing driver in the Linux 2.6.35 sources from Freescale [1].
>
> I would love not being stuck with such an old version ;)
>
> [1] http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/power/mxs?h=imx_2.6.35_maintain

I haven't seen any patches for upstreaming the battery charger on mxs yet..

In this discussion Robert Schwebel reports to be using a mainline
kernel with the battery charger driver on mx23:
https://community.freescale.com/thread/312468

Adding Robert in case he could comment on this.

Regards,

Fabio Estevam
