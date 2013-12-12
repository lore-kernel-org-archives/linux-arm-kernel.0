From: broonie@kernel.org (Mark Brown)
Date: Thu, 12 Dec 2013 10:42:08 +0000
Subject: regulator-core has_full_constraints set too late for dt using
 boards ?
In-Reply-To: <52A98C72.2040203@redhat.com>
References: <52A88805.1080704@redhat.com>
 <20131211160225.GB11468@sirena.org.uk>
 <52A98C72.2040203@redhat.com>
Message-ID: <20131212104208.GG11044@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 11:14:10AM +0100, Hans de Goede wrote:
> On 12/11/2013 05:02 PM, Mark Brown wrote:

> >Please look at the current code, that's not how this works any more.

> More current then 3.13-rc3 ? Because that is what I've been looking at.

Yes, -next.  It'll be going to Linus probably this week.

> I could be completely wrong of course. Either way could you give a few
> hints as to how my interpretation of how this works is wrong ?

It's correct for the code you've been looking at but has since been
changed.  Please look at the changes in -next, you should generally
check -next for the current state of things.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131212/b8104725/attachment-0001.sig>
