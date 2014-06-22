From: broonie@kernel.org (Mark Brown)
Date: Sun, 22 Jun 2014 11:35:02 +0100
Subject: [PATCH 1/3 v5] spi: s3c64xx: fix broken "cs_gpios" usage in the
 driver
In-Reply-To: <CAHfPSqCvHRMxPAVgRDrP-BSwuwJRP5O8Z+xy5Xot8t8mASNyAA@mail.gmail.com>
References: <1402631992-500-1-git-send-email-ch.naveen@samsung.com>
 <CAD=FV=Ua+P0CBAfNj4SWWMWRKcEFdmh=akwy1-ZWoGOt2P9=cQ@mail.gmail.com>
 <20140621095149.GY5099@sirena.org.uk>
 <CAHfPSqCvHRMxPAVgRDrP-BSwuwJRP5O8Z+xy5Xot8t8mASNyAA@mail.gmail.com>
Message-ID: <20140622103502.GJ24291@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 21, 2014 at 10:53:14PM +0530, Naveen Krishna Ch wrote:

> The revisions were pretty quick

Yes, this is part of what I'm concerned about - it often means that
there are problems, either the review wasn't very detailed or the code
is being written too hastily.  In this case this is coupled with the
fact that it's an area of the code that has had problems in general is
setting off alarm bells.

> v4 to v5 : Added Acked-by and Revewied-by from Javier and Rob Herring

Don't resend for tags - you should include tags if you do resend but
they're not a good reason to do so.

> Kindly review and let us know your comments.

I will review it when I get to it, this isn't the only thing I've got
sitting for review.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140622/f6900888/attachment.sig>
