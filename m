From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 25 Oct 2012 09:55:22 +0300
Subject: Possible regression in arm/io.h
In-Reply-To: <20121024105223.GC23775@mudshark.cambridge.arm.com>
References: <CABYn4syj0GZAsDYVQfXg_qKAFkbrxPLoZWpKRzwf3gfRkMGZkQ@mail.gmail.com>
 <20121024105223.GC23775@mudshark.cambridge.arm.com>
Message-ID: <1351148122.2507.63.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-10-24 at 11:52 +0100, Will Deacon wrote:
> 	(a) Understand what has changed in GCC to cause this error to start
> 	    cropping up.

This is about already quite old gcc 4.6.3, which I use for about 4 last
kernel releases already. So it is only the kernel that changed.

You can download the GCC I used from here:
http://kernel.org/pub/tools/crosstool/

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121025/15484097/attachment.sig>
