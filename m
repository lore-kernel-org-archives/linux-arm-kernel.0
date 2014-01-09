From: broonie@kernel.org (Mark Brown)
Date: Thu, 9 Jan 2014 13:35:33 +0000
Subject: [RFC 10/18] regulator: vexpress: Use regmap instead of custom
 interface
In-Reply-To: <1389205531.23721.40.camel@hornet>
References: <1387815830-8794-1-git-send-email-pawel.moll@arm.com>
 <1387815830-8794-11-git-send-email-pawel.moll@arm.com>
 <20131224122455.GY30815@sirena.org.uk>
 <1389205531.23721.40.camel@hornet>
Message-ID: <20140109133533.GO31886@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 06:25:31PM +0000, Pawel Moll wrote:
> On Tue, 2013-12-24 at 12:24 +0000, Mark Brown wrote:

> > If this change is making the operations hardware agnostic regmap based
> > ones then they should be being either replaced with standard operations
> > or standard operations being added.  It looks like you should be able to
> > use the existing linear map operations.

> Bad wording on my side. What I meant was: it doesn't matter what wacky
> VE-specific interface is hidden behind the regmap, not it's a generic
> regulator driver.

OK.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140109/43746391/attachment.sig>
