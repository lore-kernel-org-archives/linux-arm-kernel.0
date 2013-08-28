From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 27 Aug 2013 17:55:28 -0700
Subject: [PATCH v3 13/31] clk: wrap I/O access for improved portability
In-Reply-To: <20130824000539.5554cad8@crub>
References: <1374166855-7280-1-git-send-email-gsi@denx.de>
 <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1374495298-22019-14-git-send-email-gsi@denx.de>
 <20130802223000.6450.97817@quantum> <20130824000539.5554cad8@crub>
Message-ID: <20130828005528.8231.80079@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Anatolij Gustschin (2013-08-23 15:05:39)
> On Fri, 02 Aug 2013 15:30:00 -0700
> Mike Turquette <mturquette@linaro.org> wrote:
> 
> > Quoting Gerhard Sittig (2013-07-22 05:14:40)
> > > the common clock drivers were motivated/initiated by ARM development
> > > and apparently assume little endian peripherals
> > > 
> > > wrap register/peripherals access in the common code (div, gate, mux)
> > > in preparation of adding COMMON_CLK support for other platforms
> > > 
> > > Signed-off-by: Gerhard Sittig <gsi@denx.de>
> > 
> > I've taken this into clk-next for testing. regmap deserves investigation
> > but I don't think your series should be blocked on that. We can always
> > overhaul the basic clock primitives with regmap support later on if that
> > makes sense.
> 
> Mike, I cannot see it in clk-next branch of
> git://git.linaro.org/people/mturquette/linux.git
> 
> Can you please check? Or am I looking in the wrong place?

You were looking in the right place but I had not pushed out the latest
patches from my local branch. It should be there now.

Regards,
Mike

> 
> Thanks,
> Anatolij
