From: ijc@hellion.org.uk (Ian Campbell)
Date: Thu, 09 Feb 2012 06:34:50 +0000
Subject: [regression] Re: Enabling runtime P2V by default
In-Reply-To: <20120206232328.GA1941@burratino>
References: <1312918898-11894-1-git-send-email-linus.walleij@stericsson.com>
 <20110810091635.GF1831@n2100.arm.linux.org.uk>
 <20110810092206.GE10121@e102144-lin.cambridge.arm.com>
 <20120206223147.GA3760@burratino>
 <alpine.LFD.2.02.1202061514430.1656@xanadu.home>
 <20120206232328.GA1941@burratino>
Message-ID: <1328769290.13189.76.camel@dagon.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-02-06 at 17:23 -0600, Jonathan Nieder wrote:
> Nicolas Pitre wrote:
> 
> > You really do want to have uboot patched.  Who knows what other latent 
> > issues are there that you don't know about.
> 
> Ah, sorry for the lack of clarity.  I don't believe this u-boot patch[1]
> has been committed anywhere, so even people with the latest u-boot are
> affected.  It's just available from the mailing list archive.

FYI it has now been applied to the Marvell u-boot custodian's tree:
git://git.denx.de/u-boot-marvell.git

Ian.

-- 
Ian Campbell


An evil mind is a great comfort.
