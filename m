From: peter@stuge.se (Peter Stuge)
Date: Wed, 17 Oct 2012 18:51:25 +0200
Subject: PDF documentation
In-Reply-To: <CAE7jHC8ru3TVaRXWvn5p6795LTk-WkVZZRJxB1-vJag+=H62jw@mail.gmail.com>
References: <CAE7jHC83biZy7TNYSr+-X85tpenqtAHuwSO47Q-6+XRF0fUxLA@mail.gmail.com>
 <20121016140555.12139.qmail@stuge.se>
 <CAE7jHC8ru3TVaRXWvn5p6795LTk-WkVZZRJxB1-vJag+=H62jw@mail.gmail.com>
Message-ID: <20121017165125.12301.qmail@stuge.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Constantine Shulyupin wrote:
> >> - what PDF documentation do you use? (You can just drop a link to PDF,
> >> for example http://www.ti.com/lit/ds/symlink/omap4430.pdf)
> >
> > I don't understand what you want to know. I have thousands of data
> > sheets for parts that I have used, use, or plan to use.
> 
> Peter, can you please just send me some links to most frequently
> used online PDF?

I don't have a particular PDF that is used more frequently than
others. Here's one I used recently, for a common flash chip:

http://www.macronix.com/QuickPlace/hq/PageLibrary4825740B00298A3B.nsf/h_Index/DBACA1C90564EBB248257639003A563A/$File/MX29GL128E,%203V%20(VI-O),%20128Mb,%20v1.5.pdf


> I would like to convert them to html and see how usable it is.

As others also mention I think that is backwards. If you want to do
something good for documentation then look for workflows where a
single source format allows to perfectly generate a variety of output
formats.

Perfectly matters. Anyone can cobble up a script to render characters
on a PDF page. It will look awful, which distracts readers, which
generates more support inquiries.

PDF is a digital sheet media. HTML comes nowhere near the tools
PDF offers for typesetting and typography. PDFs can be made beautiful
without a lot of effort.

Creating beautiful HTML is, let's say, uneconomical. Let's not talk
about how it limits the designer. (That's what really good web
designers do - know those limits yet still create working UX.)

Check out PostScript and then check out HTML. The similarities may be
comparable to those of a magnificent fil?t knife and a wooden spoon.

One can of course prepare food with both.


As I mentioned before, I still find HTML superior for discovery and
early selection of new products. It is unneccessarily and
unpleasantly time-consuming to deal with PDF documents if there is a
particular requirement which needs to be checked against a large
number of available products. I was looking for a low-profile SMD
pushbutton recently, and in order to find the information I needed I
had to view a lot of PDFs at many manufacturers. One manufacturer
however had the information *right there* on the product family web
page. That saved me a lot of time, and I chose one of their products.


//Peter
