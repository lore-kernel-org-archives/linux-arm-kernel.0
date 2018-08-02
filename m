From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 2 Aug 2018 06:54:21 -0700
Subject: [RESEND PATCH 6/6] arm64: enable RapidIO menu in Kconfig
In-Reply-To: <20180802134544.GG38497@guest228.east.isi.edu>
References: <20180731142954.30345-1-acolin@isi.edu>
 <20180731142954.30345-7-acolin@isi.edu>
 <20180801095404.GA17585@infradead.org>
 <fad8661c-cd8c-3a9c-ca03-5d2f63893a24@gmail.com>
 <CAMuHMdVDra1MKcuuD0SqEYXSggr0iVFcbcjL33z7JuiE1_y8yw@mail.gmail.com>
 <20180802134544.GG38497@guest228.east.isi.edu>
Message-ID: <20180802135421.GA13512@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 02, 2018 at 09:45:44AM -0400, Alexei Colin wrote:
> If I move RapidIO option to drivers/Kconfig, then it won't appear under
> the Bus Options/System Support menu, along with other choices for the
> system bus (PCI, PCMCIA, ISA, TC, ...).

It's not like anyone cares.  And FYI, moving all those to
drivers/Kconfig is osmething I will submit for the next merge window.

> Alex explains above that RapidIO
> may be selected as a system bus on some architectures, and users expect
> it to be in the menu in which it has been for some time now.  What
> problem is the current organization causing?

A "system bus" seems like a rather outdated concept to start with.
