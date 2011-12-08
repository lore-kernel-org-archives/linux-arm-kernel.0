From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 8 Dec 2011 20:18:37 +0800
Subject: [PATCH V2 2/2] ARM: mx51/53: add round_rate for esdhc clocks
In-Reply-To: <20111208093310.GT27267@pengutronix.de>
References: <1323307714-21290-1-git-send-email-richard.zhao@linaro.org>
 <1323307714-21290-3-git-send-email-richard.zhao@linaro.org>
 <20111208093310.GT27267@pengutronix.de>
Message-ID: <20111208121755.GA1837@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 10:33:10AM +0100, Sascha Hauer wrote:
> Hi Richard,
> 
> On Thu, Dec 08, 2011 at 09:28:34AM +0800, Richard Zhao wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > ---
> >  arch/arm/mach-imx/clock-mx51-mx53.c |   42 ++++++++++++++++++++--------------
> >  1 files changed, 25 insertions(+), 17 deletions(-)
> > 
> 
> Is it worth it to queue this one given that you are working on generic
> clock support for i.MX5?
I think yes. I don't know when generic clock go into mainline,
at leat in serveral months.

Thanks
Richard
> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
