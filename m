From: jrnieder@gmail.com (Jonathan Nieder)
Date: Mon, 6 Feb 2012 17:23:29 -0600
Subject: [regression] Re: Enabling runtime P2V by default
In-Reply-To: <alpine.LFD.2.02.1202061514430.1656@xanadu.home>
References: <1312918898-11894-1-git-send-email-linus.walleij@stericsson.com>
 <20110810091635.GF1831@n2100.arm.linux.org.uk>
 <20110810092206.GE10121@e102144-lin.cambridge.arm.com>
 <20120206223147.GA3760@burratino>
 <alpine.LFD.2.02.1202061514430.1656@xanadu.home>
Message-ID: <20120206232328.GA1941@burratino>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Pitre wrote:

> You really do want to have uboot patched.  Who knows what other latent 
> issues are there that you don't know about.

Ah, sorry for the lack of clarity.  I don't believe this u-boot patch[1]
has been committed anywhere, so even people with the latest u-boot are
affected.  It's just available from the mailing list archive.

"It's not worth working around this bootloader bug" may still be the
right answer.  After all, in a couple of months presumably most people
will have the patch applied.  And for all I know, it might not even be
possible to work around this bootloader bug, short of flipping the P2V
default again (which seems like a bad idea).  I just wanted to make
sure you were aware of it.

Cheers,
Jonathan

[1] http://thread.gmane.org/gmane.comp.boot-loaders.u-boot/124051/focus=124062
