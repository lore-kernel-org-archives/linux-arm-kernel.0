From: broonie@kernel.org (Mark Brown)
Date: Tue, 15 Jul 2014 12:00:00 +0100
Subject: [PATCH 1/3 v6] spi: s3c64xx: fix broken "cs_gpios" usage in the
 driver
In-Reply-To: <CAHfPSqAgCbfL2nkrfSYNJZitT-nGw7+5fpR9FMaabmwVJM6jUQ@mail.gmail.com>
References: <1405316506-27855-1-git-send-email-ch.naveen@samsung.com>
 <1405316506-27855-2-git-send-email-ch.naveen@samsung.com>
 <20140714172524.GH6800@sirena.org.uk>
 <CAHfPSqAzab931yurSs+3zj=uoFj93FuAdd24AQKm1fZm07Nq8Q@mail.gmail.com>
 <20140714191533.GH6800@sirena.org.uk>
 <CAHfPSqAgCbfL2nkrfSYNJZitT-nGw7+5fpR9FMaabmwVJM6jUQ@mail.gmail.com>
Message-ID: <20140715110000.GA17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 09:33:21AM +0530, Naveen Krishna Ch wrote:
> On 15 July 2014 00:45, Mark Brown <broonie@kernel.org> wrote:

> > The problem isn't what you're trying to do, the problem is verifying
> > that it has been done correctly - making sure that everything has been
> > accounted for in the change itself.

> Understand your concern. I will try to get it tested on as many platforms.

That's useful, but please note that it's mainly a code review thing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140715/b184429c/attachment.sig>
