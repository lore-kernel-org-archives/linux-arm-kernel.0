From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 18 Feb 2015 10:14:08 -0800
Subject: [PATCH] Revert "clk: mxs: Fix invalid 32-bit access to frac
 registers"
In-Reply-To: <CAOMZO5Akvc3-h_=wj5P2aM__w8dX4kdLCuELwg9T0t=S5--zrw@mail.gmail.com>
References: <1423773007-10752-1-git-send-email-stefan.wahren@i2se.com>
 <CAOMZO5Akvc3-h_=wj5P2aM__w8dX4kdLCuELwg9T0t=S5--zrw@mail.gmail.com>
Message-ID: <20150218181408.421.47911@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Fabio Estevam (2015-02-12 13:12:37)
> On Thu, Feb 12, 2015 at 6:30 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> > Revert commit 039e59707507 (clk: mxs: Fix invalid 32-bit access to frac
> > registers), because it leads to a faulty spi communication on mx28evk.
> >
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Thanks, Stefan
> 
> Tested-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied to clk-next.

Regards,
Mike
