From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Oct 2017 15:40:21 +0100
Subject: SPI regression in today's Linux next
In-Reply-To: <20171017143454.GA4394@atomide.com>
References: <20171017143454.GA4394@atomide.com>
Message-ID: <20171017144021.r7aydswer7anb5ha@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 07:34:54AM -0700, Tony Lindgren wrote:
> Hi Lucas and Mark,
> 
> Looks like commit 9ce70d49fa80 ("spi: fix IDR collision on systems with
> both fixed and dynamic SPI bus numbers") causes the following regression
> at least for omaps. Reverting commit 9ce70d49fa80 fixes it.
> 
> Any ideas?

There's a fix already.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171017/30a4348f/attachment-0001.sig>
