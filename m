From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Nov 2013 11:57:44 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <20131119113015.GH5914@e106331-lin.cambridge.arm.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <20131115175241.GB27174@quad.lixom.net>
 <20131119113015.GH5914@e106331-lin.cambridge.arm.com>
Message-ID: <20131119115744.GK16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 11:30:15AM +0000, Mark Rutland wrote:
> I'm not sure it's entirely reasonable to assume that Microsoft will
> swoop in and develop standards that are useful to us or even applicable
> to the vast majority of the systems that are likely to exist.

It's not in their interest to do this, so it won't happen.

> Outside of the ARM Linux community there is work ongoing to change ACPI
> to better suit the level of variation we seem in the ARM space (see
> Darren Hart's presentation from ELCE [1]). We need to be involved now in
> order to make sure that this is actually generally applicable.

It may have been interesting to have attended some of these talks, but
because the LF botched up and never told the KSummit invitees that they
had free access to ELCE until after ELCE had finished...

> I think that we need to be involved in ACPI from today if we have any
> hope of having something sane in future.

I fully agree with that.  If we're not involved now, we're going to end
up with something that's already designed and implemented on systems
which we'll then _have_ no option but to accept or just not be able to
run mainline kernels on such systems.

To ignore ACPI now would be extremely n?ieve.
