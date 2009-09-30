From: rpjday@crashcourse.ca (Robert P. J. Day)
Date: Wed, 30 Sep 2009 11:15:37 -0400 (EDT)
Subject: apparently, numerous unused header files under arch/arm
In-Reply-To: <4AC36F91.3050503@billgatliff.com>
References: <alpine.LFD.2.00.0909300405080.14643@localhost>
	<4AC36F91.3050503@billgatliff.com>
Message-ID: <alpine.LFD.2.00.0909301113420.18061@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Sep 2009, Bill Gatliff wrote:

> Robert P. J. Day wrote:
> >   as part of a new tree scan with one of my scripts, i located
> > what *appear* to be numerous header files under arch/arm that no
> > one seems to be including.  the first few in that list,
> > accompanied by a full tree scan of any use of the filename:
>
> Would any of those files be of use to user applications?

  don't know -- the script doesn't filter based on any Kbuild files,
so it's entirely possible that there are false positives.  give me a
few minutes and i'll post the list.  it contains 58 files, sorted by
subdirectory so, really, it's not *overwhelmingly* long.

  i can post the script as well, but give me a chance to clean it up a
bit first.

rday
--

========================================================================
Robert P. J. Day                               Waterloo, Ontario, CANADA

        Linux Consulting, Training and Annoying Kernel Pedantry.

Web page:                                          http://crashcourse.ca
Twitter:                                       http://twitter.com/rpjday
========================================================================
