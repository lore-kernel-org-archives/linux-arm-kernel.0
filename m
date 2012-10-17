From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Oct 2012 23:19:40 +0100
Subject: PDF documentation
In-Reply-To: <20121016140555.12139.qmail@stuge.se>
References: <CAE7jHC83biZy7TNYSr+-X85tpenqtAHuwSO47Q-6+XRF0fUxLA@mail.gmail.com>
 <20121016140555.12139.qmail@stuge.se>
Message-ID: <20121017221940.GP21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 16, 2012 at 04:05:55PM +0200, Peter Stuge wrote:
> > Sometimes it is more easy just to copy paste and send by email part
> > of documentation instead of using hyperlinks.
> 
> A group collaborating around a given hardware certainly needs a
> common repository of documentation. A file server is often used
> internally. I like to use wikis for public projects. They make it
> easy to upload PDF files, references can be made to page
> number+section.

This actually depends.  You have to be careful of copyright infringement.
Generally, you are allowed to download and store one copy of the
documentation for your own personal use and not redistribute it.  Whether
it says for personal use or not is another gotcha there.

Most places have fair use allowed in law, which means that the copy and
paste of limited extracts is permitted - but in this day and age of global
networks, you have to be really careful because your local law may not
be the applicable law.

> > I found, that it is more easy work (and work collaboratively) with
> > documentation in HTML format. Sometimes it is possible just to
> > convert PDF to HTML.
> 
> I strongly prefer working with PDF because it is the canonical
> documentation made available by the manufacturer and because my
> PDF readers are much much better than my HTML readers.

Again, copyright may be an issue with this kind of approach, because
you're technically redistributing someone elses work.  You need to
check what you're permitted to do with each document before you do it,
and if you aren't permitted to redistribute it, seek permission from the
copyright owner.

I'm not sure how the various datasheet sites get around this, but I
suspect they may have negotiated blanket permissions with most of the
silicon manufacturers, espsecially as some modify the PDFs adding
a final page to them.

> More useful for initial impression, yes, but under no circumstance do
> I think HTML would be a good replacement for PDF. Already the fact
> that PDF is self-contained but HTML is not should suggest that HTML
> is a poor representation outside the web browser, for anything
> really.

The big problem with anything online is that you must be online to access
it.  If your connection to the Internet goes down, you lose access to
that information.  If the site hosting it goes down, same problem...


(In the old days of databooks, companies used to either be given the
databook by the sales rep, or -rarely- they bought the databook, and
the book sat in the companies library... and any employee could make
use of that single copy...)
