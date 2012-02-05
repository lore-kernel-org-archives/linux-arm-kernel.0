From: linux@dominikbrodowski.net (Dominik Brodowski)
Date: Sun, 5 Feb 2012 22:20:04 +0100
Subject: [PATCH,FIXED] PCMCIA card inserted, five s2ram cycles, you're dead
In-Reply-To: <20120122091248.GS1068@n2100.arm.linux.org.uk>
References: <20120122085157.GR1068@n2100.arm.linux.org.uk>
 <20120122091248.GS1068@n2100.arm.linux.org.uk>
Message-ID: <20120205212004.GE13598@comet.dominikbrodowski.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2012 at 09:12:48AM +0000, Russell King - ARM Linux wrote:
> Unfortunately, the description will need a couple of edits for it to
> apply properly (I just applied it to a local private branch.)
> 
> On Sun, Jan 22, 2012 at 08:51:57AM +0000, Russell King - ARM Linux wrote:
> > @@ -546,8 +524,8 @@ static int socket_late_resume(struct pcmcia_socket *skt)
> 
> This needs a space before it, otherwise git will try to take this as a
> patch to be applied.
> 
> > Cc: <stable@vger.kernel.org>
> > Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > -- 
> 
> And I keep messing this marker up in hand-crafted messages.

Applied, thanks.

Best,
	Dominik
