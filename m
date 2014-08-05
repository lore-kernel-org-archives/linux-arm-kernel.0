From: sam@ravnborg.org (Sam Ravnborg)
Date: Tue, 5 Aug 2014 11:14:26 +0200
Subject: [PATCH v3 1/3] asm-generic/io.h: Implement generic
 {read,write}s*()
In-Reply-To: <CAMuHMdUUSMGghDVDpdQygQCv0OWGP-Lwxzy004xRpR6BsZS81A@mail.gmail.com>
References: <1405508484-18303-1-git-send-email-thierry.reding@gmail.com>
 <43703371.jktNRIezc3@wuerfel> <20140719084152.GA31564@ravnborg.org>
 <4967546.K5Yf5hcJE1@wuerfel> <20140719091156.GA31772@ravnborg.org>
 <CAMuHMdUUSMGghDVDpdQygQCv0OWGP-Lwxzy004xRpR6BsZS81A@mail.gmail.com>
Message-ID: <20140805091426.GA28220@ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >
> > So xxx_p is for pause (or something like that).
> > This also matches that m68k do some tricks with delay() in the _p variants.
> > Thanks for the explanation.
> 
> m68k's isa_delay() uses the same approach as x86's slow_down_io(),
> but only for Q40/Q60, which has a "real" ISA bus that accepts legacy
> ISA expansion cards (http://www.q40.de/).
Based on the nice description from James I have on my todo list
to cook up a patch to io.h to document this.
Had just not got around to do it yet.

	Sam
