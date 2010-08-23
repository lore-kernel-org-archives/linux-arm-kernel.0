From: david-b@pacbell.net (David Brownell)
Date: Mon, 23 Aug 2010 09:36:34 -0700 (PDT)
Subject: [PATCH] pio: add arch specific gpio_is_valid() function
In-Reply-To: <1282575669-24501-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <30193.50267.qm@web180305.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



--- On Mon, 8/23/10, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> From: Nicolas Ferre <nicolas.ferre@atmel.com>
> Subject: [PATCH] pio: add arch specific gpio_is_valid() function

What's the rationale?  It's valid or not.  And there's already a
function whose job it is to report that status ... which is set up
for arch customization.  Which ISTR worked fine for AT91 (among other
platforms) ...

So my first reacion is "NAK, pointless".

> 
