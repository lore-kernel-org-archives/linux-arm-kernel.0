From: ciminaghi@gnudd.com (Davide Ciminaghi)
Date: Mon, 3 Dec 2012 14:31:50 +0100
Subject: [PATCH 2/8] gpio: pl061 depends on ARM
In-Reply-To: <CACRpkdZAW_O0AoZD=uOHu7BmEAAbmbc8kLqWfm7iDQrs0TgRdA@mail.gmail.com>
References: <1353683310-23654-1-git-send-email-ciminaghi@gnudd.com>
 <1353683310-23654-3-git-send-email-ciminaghi@gnudd.com>
 <CACRpkdZAW_O0AoZD=uOHu7BmEAAbmbc8kLqWfm7iDQrs0TgRdA@mail.gmail.com>
Message-ID: <20121203133150.GC12290@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 01, 2012 at 04:11:08PM +0100, Linus Walleij wrote:
> On Fri, Nov 23, 2012 at 4:08 PM, Davide Ciminaghi <ciminaghi@gnudd.com> wrote:
> 
> > From: Alessandro Rubini <rubini@gnudd.com>
> >
> > Commit dece904d (gpio: pl061: use chained_irq_* functions in irq
> > handler) introduced chained_irq_enter/exit, which is only
> > available for arch/arm and the driver won't compile elsewhere.
> >
> > The dependency is thus made explicit, because AMBA is used in the x86
> > world by a PCI-to-AMBA bridge, to be submitted.
> >
> > Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> > Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>
> 
> Patch applied with Viresh's ACK.
>
ok thanks a lot and regards

Davide
