From: broonie@kernel.org (Mark Brown)
Date: Thu, 12 Dec 2013 13:16:54 +0000
Subject: regulator-core has_full_constraints set too late for dt using
 boards ?
In-Reply-To: <52A9B48A.8040601@redhat.com>
References: <52A88805.1080704@redhat.com>
 <20131211160225.GB11468@sirena.org.uk>
 <52A98C72.2040203@redhat.com>
 <20131212104208.GG11044@sirena.org.uk>
 <52A9A9DB.5050102@redhat.com>
 <20131212122347.GK11044@sirena.org.uk>
 <52A9B48A.8040601@redhat.com>
Message-ID: <20131212131654.GL11044@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 02:05:14PM +0100, Hans de Goede wrote:
> On 12/12/2013 01:23 PM, Mark Brown wrote:

> >It's sitting in my review queue, it's not very well described so it's
> >not clear that you've selected the correct criteria and I need to find
> >time to actually look at it properly.

> Since regulator_get_optional is the only one calling
> _regulator_get() with both allow_dummy and exclusive set to
> false I've added the following condition to printing the
> error:

Put some of this analysis in the commit message and perhaps a comment in
the code please...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/a3e93479/attachment.sig>
