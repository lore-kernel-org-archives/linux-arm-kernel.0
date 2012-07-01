From: rubini@gnudd.com (Alessandro Rubini)
Date: Sun, 1 Jul 2012 13:04:54 +0200
Subject: [PATCH V2 5/6] x86: add CONFIG_ARM_AMBA, selected by STA2X11
In-Reply-To: <20120701105934.GD16319@n2100.arm.linux.org.uk>
References: <20120701105934.GD16319@n2100.arm.linux.org.uk>
 <4FECB95D.7010200@zytor.com> <cover.1338222460.git.rubini@gnudd.com>
 <f85fefb10b7a7407b77180be65b18bf0426145b9.1338222461.git.rubini@gnudd.com>
 <20120701104401.GA4352@mail.gnudd.com>
Message-ID: <20120701110454.GA17531@mail.gnudd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I think the answer is... those primecell drivers need fixing in some way.

Ok. I'm going to attack them and make a report.

> As for PL08x, which depends on asm/hardware/pl080.h,

We have pl080 under PCI, so we have patches in the queue to fix this
header problem.  I just didn't submit them yet, but now they are part
of this fixup effort and I'll check them over.

> Note also that hpa has only reported the first errors he encountered, so
> there may be more, and that's somehting which needs checking.

Yes. I'm going to make a status report soon, counting and classifying
all errors I encounter when enabling all amba drivers under x86.

thanks
/alessandro
