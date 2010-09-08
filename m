From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Wed, 8 Sep 2010 01:11:12 +0100
Subject: [PATCH] pio: add arch specific gpio_is_valid() function
In-Reply-To: <616992.75276.qm@web180302.mail.gq1.yahoo.com>
References: <20100907222230.4a3594be@lxorguk.ukuu.org.uk>
	<616992.75276.qm@web180302.mail.gq1.yahoo.com>
Message-ID: <20100908011112.6469db62@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 Sep 2010 16:44:55 -0700 (PDT)
David Brownell <david-b@pacbell.net> wrote:

> 
> 
> --- On Tue, 9/7/10, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > > 
> > > ?????device->output_pin = -EINVAL;
> > 
> > gpio numbers are unsigned in the rest of the API
> 
> Minor goof; should have been "int" everywhere,
> as implied by the references to negative numbers
> in the docs... negatives not used internally, but
> preserved for external use (as above).

Ok I need to patch a couple of the intel drivers to use -1 then.

Alan
