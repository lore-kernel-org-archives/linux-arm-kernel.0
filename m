From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 23 May 2014 12:13:59 -0700
Subject: [PATCH 10/10] clk: versatile: add versatile OSC support
In-Reply-To: <CACRpkdbjAa6Y-EVwK=D9eiA6JoW+pgxtnHCsrZSTZOY5uozMpw@mail.gmail.com>
References: <1400620176-7239-1-git-send-email-robherring2@gmail.com>
 <1400620176-7239-11-git-send-email-robherring2@gmail.com>
 <CACRpkdbjAa6Y-EVwK=D9eiA6JoW+pgxtnHCsrZSTZOY5uozMpw@mail.gmail.com>
Message-ID: <20140523191359.23136.57893@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Linus Walleij (2014-05-23 06:31:26)
> On Tue, May 20, 2014 at 11:09 PM, Rob Herring <robherring2@gmail.com> wrote:
> 
> > From: Rob Herring <robh@kernel.org>
> >
> > Versatile platforms share the same OSC programming model as Integrator
> > platforms. Add the necessary parameters and init functions for Versatile.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > Cc: Mike Turquette <mturquette@linaro.org>
> > ---
> >  drivers/clk/versatile/Makefile         |  3 +--
> >  drivers/clk/versatile/clk-integrator.c | 35 ++++++++++++++++++++++++++++++++--
> 
> So then this is a good opportunity to rename that file from clk-integrator.c
> to something else, right? Usually we use "versatile" to refer to the
> whole family of boards but other names are possible I guess.
> 
> Apart from that it looks good :-)

Looks good to me too. Rob will you incorporate the file name change?

Regards,
Mike

> 
> Yours,
> Linus Walleij
