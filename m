From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Jul 2012 18:04:15 +0100
Subject: [PATCH v2 05/15] ARM: integrator: use fixed PCI i/o mapping
In-Reply-To: <CACRpkda_to3CzfhvOh-NDx_7Qz+Reg6m1k+uH2stRFy8KSqQmQ@mail.gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
 <1342231451-28861-6-git-send-email-robherring2@gmail.com>
 <CACRpkda_to3CzfhvOh-NDx_7Qz+Reg6m1k+uH2stRFy8KSqQmQ@mail.gmail.com>
Message-ID: <20120717170413.GG14624@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 14, 2012 at 10:49:47PM +0100, Linus Walleij wrote:
> On Sat, Jul 14, 2012 at 4:04 AM, Rob Herring <robherring2@gmail.com> wrote:
> 
> > From: Rob Herring <rob.herring@calxeda.com>
> >
> > Move integrator PCI to fixed i/o mapping and remove io.h.
> >
> > Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> 
> I think the PCI bus on my Integrator/AP is tilted and not suitable
> for tests. But IIRC Will Deacon actually has one of these machines
> and managed to get ethernet going on it. Maybe he can even test
> this patch?

I can try digging out my integrator at the weekend if you like. Are these
patches sitting in a branch anywhere that I can grab?

Will
