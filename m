From: broonie@kernel.org (Mark Brown)
Date: Thu, 12 Dec 2013 12:23:47 +0000
Subject: regulator-core has_full_constraints set too late for dt using
 boards ?
In-Reply-To: <52A9A9DB.5050102@redhat.com>
References: <52A88805.1080704@redhat.com>
 <20131211160225.GB11468@sirena.org.uk>
 <52A98C72.2040203@redhat.com>
 <20131212104208.GG11044@sirena.org.uk>
 <52A9A9DB.5050102@redhat.com>
Message-ID: <20131212122347.GK11044@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 01:19:39PM +0100, Hans de Goede wrote:

> Note my patch to not do a dev_err when no regulator is found for
> regulator_get_optional still is needed in -next.

It's sitting in my review queue, it's not very well described so it's
not clear that you've selected the correct criteria and I need to find
time to actually look at it properly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/c792fad9/attachment.sig>
