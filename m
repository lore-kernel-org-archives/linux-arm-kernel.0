From: mturquette@baylibre.com (Michael Turquette)
Date: Tue, 28 Jun 2016 15:21:19 -0700
Subject: [PATCH 1/3] clk: sunxi: Add a driver for the CCU
In-Reply-To: <20160628204502.GG5550@lukather>
References: <cover.1467135898.git.moinejf@free.fr>
 <a55dc5d1a9f02dc4d71d5c21064bffebe5a7b149.1467135898.git.moinejf@free.fr>
 <20160628204502.GG5550@lukather>
Message-ID: <146715247912.89261.8162176265913264908@resonance>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Maxime Ripard (2016-06-28 13:45:02)
> What's the point of this, if we're not using (or exposing for that
> matter) any of it?
> 
> I'm sorry, but the whole point of the initial serie was to rework and
> simplify things, precisely because dealing with the clk_factors code
> was just too difficult nowadays. And this doesn't solve anything on
> that aspect.
> 
> We came with an approach that have all the maintainers involved
> agreeing on it, I don't see why we should start over. There's some
> useful features there (like tracing). But it's something that can be
> added, and should be done differently anyway.

Yes, let's not delay Maxime's work any longer. Stephen and I have
requested these changes to the sunxi clock drivers for a long time and
now we have them. I intend to merge Maxime's v3 once it addresses the
last round of review questions.

Regards,
Mike

> 
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
