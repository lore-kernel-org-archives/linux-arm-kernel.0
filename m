From: ynvich@gmail.com (Sergei Ianovich)
Date: Thu, 05 Dec 2013 08:36:41 +0400
Subject: [PATCH 01/11] resolve PXA<->8250 serial device address conflict
In-Reply-To: <20131205043544.GA28580@kroah.com>
References: <1385879185-22455-1-git-send-email-ynvich@gmail.com>
 <1385879185-22455-2-git-send-email-ynvich@gmail.com>
 <20131202090253.GE3942@xps8300> <1385976238.12531.8.camel@host5.omatika.ru>
 <20131202094932.GF3942@xps8300>
 <1385980005.12531.21.camel@host5.omatika.ru>
 <20131202141033.GK3942@xps8300> <20131205041251.GA24906@kroah.com>
 <1386217896.7152.8.camel@host5.omatika.ru>
 <20131205043544.GA28580@kroah.com>
Message-ID: <1386218201.7152.10.camel@host5.omatika.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-12-04 at 20:35 -0800, Greg Kroah-Hartman wrote:
> On Thu, Dec 05, 2013 at 08:31:36AM +0400, Sergei Ianovich wrote:
> > I'm reading the last message as a confirmation that
> > drivers/tty/serial/pxa.c needs to be rewritten using 8250_core.c.
> 
> Yes, how much work is this really?

Great. It seems two drivers practically match. I'll do and submit a
merge patch.
