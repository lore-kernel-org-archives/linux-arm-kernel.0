From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 15 Jun 2016 10:25:10 +0100
Subject: [PATCH v2] arm64: allow building with kcov coverage on ARM64
In-Reply-To: <CAG_fn=X521a9uD1bthDZ-swO9hrfq=jE2C_LUvzkn6C_q5dBvA@mail.gmail.com>
References: <1465923441-107596-1-git-send-email-glider@google.com>
 <20160614175543.GA2468@leverpostej>
 <CAG_fn=X521a9uD1bthDZ-swO9hrfq=jE2C_LUvzkn6C_q5dBvA@mail.gmail.com>
Message-ID: <20160615092509.GA3984@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 14, 2016 at 08:16:08PM +0200, Alexander Potapenko wrote:
> On Tue, Jun 14, 2016 at 7:55 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > I built and booted (via EFI) a kernel with this feature enabled (also
> > with the boot/Makefile change removed). I haven't tested the feature
> > itself as such, as I'm not sure how to do that.
> You can test it by running the test program from Documentation/kcov.txt.

Ah, I hadn't spotted that. If I get the chance I'll try to give that a
go.

> > FWIW, with the boot/Makefile change removed, feel free to add:
> >
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> Thank you!
> I'll wait till tomorrow for others to comment, and then will send the
> updated version.

Sounds good to me.

Mark.
