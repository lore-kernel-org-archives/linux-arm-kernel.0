From: broonie@kernel.org (Mark Brown)
Date: Thu, 7 Jan 2016 17:37:44 +0000
Subject: ION DTS changes for HiKey in -next
Message-ID: <20160107173744.GJ6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

I was just looking at DTs in -next and noticed that there is a patch
59dfafd03fc (arm64: dts: Add dts files to enable ION on Hi6220 SoC)
which adds at DT doing something for ION.  Are we sure this should be
going into the main production DT?  The bindings haven't been reviewed
as far as I can tell, the matching driver is only in staging and hasn't
been posted upstream.

Thanks,
Mark
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160107/e859508e/attachment.sig>
