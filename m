From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 19 Nov 2012 20:45:34 +0000
Subject: [PATCH] clk: move IM-PD1 clocks to drivers/clk
In-Reply-To: <20121119200238.21126.61661@nucleus>
References: <1353350711-29916-1-git-send-email-linus.walleij@linaro.org>
 <20121119200238.21126.61661@nucleus>
Message-ID: <201211192045.34729.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 19 November 2012, Mike Turquette wrote:
> Quoting Linus Walleij (2012-11-19 10:45:11)
> > diff --git a/drivers/clk/versatile/clk-impd1.c b/drivers/clk/versatile/clk-impd1.c
> > new file mode 100644
> > index 0000000..28ac702
> > --- /dev/null
> > +++ b/drivers/clk/versatile/clk-impd1.c
> > @@ -0,0 +1,96 @@
> 
> What is rule on GPL headers these days?  I notice that this file is
> missing as well as some of the other C files in drivers/clk/versatile/.

It's up to the copyright holder.

	Arnd
