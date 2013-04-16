From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Tue, 16 Apr 2013 09:12:41 +0200
Subject: [PATCH v6 0/3] of/pci: Provide common support for PCI DT parsing
In-Reply-To: <CACRpkdbSd8pRG5pUS0ymqXDSp=ZhoQa2ctVuRA0cCmUcX5qFAA@mail.gmail.com>
References: <1365693969-23907-1-git-send-email-Andrew.Murray@arm.com>
 <20130415175641.GM28693@titan.lakedaemon.net>
 <CACRpkdbSd8pRG5pUS0ymqXDSp=ZhoQa2ctVuRA0cCmUcX5qFAA@mail.gmail.com>
Message-ID: <1366096361.24994.49.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-04-15 at 20:29 +0200, Linus Walleij wrote:
> > As agreed with Rob Herring, series applied to mvebu/drivers to
> support
> > mvebu pcie driver.
> 
> Will this hit ARM SoC soon-ish so I can base a pull request for the
> Integrator on this stuff as well?

Do not send this series upstream (or even in -next) until it has been at
least build-tested and acked by the affected architectures. AFAIK it
breaks microblaze build (simple missing #include) and isn't yet tested
on powerpc (I'm on vacation, maybe somebody else on linuxppc-dev can do
it though).

Ben.
