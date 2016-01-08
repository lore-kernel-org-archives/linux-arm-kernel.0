From: broonie@kernel.org (Mark Brown)
Date: Fri, 8 Jan 2016 12:44:39 +0000
Subject: ION DTS changes for HiKey in -next
In-Reply-To: <20160108050214.GD30293@kroah.com>
References: <20160107173744.GJ6588@sirena.org.uk>
 <20160108050214.GD30293@kroah.com>
Message-ID: <20160108124439.GL6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 07, 2016 at 09:02:14PM -0800, Greg Kroah-Hartman wrote:
> On Thu, Jan 07, 2016 at 05:37:44PM +0000, Mark Brown wrote:

> > I was just looking at DTs in -next and noticed that there is a patch
> > 59dfafd03fc (arm64: dts: Add dts files to enable ION on Hi6220 SoC)
> > which adds at DT doing something for ION.  Are we sure this should be
> > going into the main production DT?  The bindings haven't been reviewed
> > as far as I can tell, the matching driver is only in staging and hasn't
> > been posted upstream.

> Isn't "staging" upstream enough for this?  :)

I wouldn't have thought so, DTs are supposed to be an ABI so we want
proper review and having had a quick glance this doesn't look like it's
a hardware description so it's not clear to me it should be in DT at all.

> If not, let me know and I'll be glad to drop this patch, it was on the
> list for a while with no objections.

Which list?  I did look for the original thread to reply to but it
seemed to be only on the Linux driver project list.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160108/f3396d79/attachment.sig>
