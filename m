From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 22 Nov 2013 22:52:56 +0000
Subject: crypto dependency in bit sliced AES
In-Reply-To: <CAKv+Gu8PESZ3uFZ6Rf+sma9QeRd7xSyrEa=RVCeDR1KtmLKEAA@mail.gmail.com>
References: <CAKv+Gu8PESZ3uFZ6Rf+sma9QeRd7xSyrEa=RVCeDR1KtmLKEAA@mail.gmail.com>
Message-ID: <20131122225256.GG16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 11:09:00PM +0100, Ard Biesheuvel wrote:
> Hello Russell,
> 
> To my surprise, Linus has decided to release 3.13-rc1 without honoring
> Herbert's crypto pull requests for 3.13
> 
> http://marc.info/?l=linux-crypto-vger&m=138381130023859&w=2
> http://marc.info/?l=linux-crypto-vger&m=138482768727213&w=2
> 
> which contain my patch 'crypto: create generic version of ablk_helper'

That's annoying.  Linus, is there any chance that this missed pull
request could happen?  It's clearly been missed for what ever reason.

If not, the commit which seems to need reverting is:
	e4e7f10bfc4069925e99cc4b428c3434e30b6c3f
