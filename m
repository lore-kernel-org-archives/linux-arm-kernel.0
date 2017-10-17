From: broonie@kernel.org (Mark Brown)
Date: Tue, 17 Oct 2017 19:46:48 +0100
Subject: SPI regression in today's Linux next
In-Reply-To: <20171017145901.GB4394@atomide.com>
References: <20171017143454.GA4394@atomide.com>
 <20171017144021.r7aydswer7anb5ha@sirena.co.uk>
 <20171017145901.GB4394@atomide.com>
Message-ID: <20171017184648.pudjzcah7ywlloud@sirena.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 07:59:02AM -0700, Tony Lindgren wrote:
> * Mark Brown <broonie@kernel.org> [171017 07:41]:

> > There's a fix already.

> OK so with next-20171016, revert 9ce70d49fa80 and pick
> 226584aedd from the spi.git tree. Seems to work for me.

Right, indeed - it'll appear in -next as soon as I've finished it for
today.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171017/989afd65/attachment.sig>
