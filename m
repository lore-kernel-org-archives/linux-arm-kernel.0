From: lost.distance@yahoo.com (Paul Parsons)
Date: Sat, 26 Nov 2011 00:37:01 +0000 (GMT)
Subject: USB Serial Gadget regression on pxa27x-udc
In-Reply-To: <87lir3kfdj.fsf@free.fr>
Message-ID: <1322267821.6806.YahooMailClassic@web29007.mail.ird.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

--- On Fri, 25/11/11, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Assuming you're using the serial gadget (g_serial) on the
> hx4700x in "non-ACM
> mode", there's a submitted fix for that in [1].
> [1]: http://www.spinics.net/lists/linux-usb/msg54600.html

Yes, that fixed it. Thank you Robert.
