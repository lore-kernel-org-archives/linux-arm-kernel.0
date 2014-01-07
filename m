From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Jan 2014 11:13:43 +0000
Subject: [PATCH] spi:fsl-dspi:add support of DSPI IP in big endian
In-Reply-To: <79669bf1a15247cb95a2609bad5e9c5d@BL2PR03MB163.namprd03.prod.outlook.com>
References: <1388388474-8662-1-git-send-email-b44548@freescale.com>
 <20131230134217.GC31886@sirena.org.uk>
 <79669bf1a15247cb95a2609bad5e9c5d@BL2PR03MB163.namprd03.prod.outlook.com>
Message-ID: <20140107111343.GW31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 03:54:25AM +0000, Chao Fu wrote:

> > Seems like there's some whitespace changes crept in here and elsewhere
> > which makes things harder to review.

> [Chao Fu] Here is some coding style not in standard in former code, 
> should I take this opportunity to modify here? 

It's fine to fix things like this but please do it as a separate patch -
it is much easier to review patches that do one thing, if there's extra
changes (especially changes that aren't mentioned in the changelog) then
people reviewing need to check harder to work out what the change is and
that it's doing what's expected.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140107/ed688af2/attachment.sig>
