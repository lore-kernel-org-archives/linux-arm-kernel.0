From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 25 Apr 2017 00:07:01 +0200
Subject: support autofocus / autogain in libv4l2
In-Reply-To: <20170424103802.00d3b554@vento.lan>
References: <1487074823-28274-1-git-send-email-sakari.ailus@linux.intel.com>
 <1487074823-28274-2-git-send-email-sakari.ailus@linux.intel.com>
 <20170414232332.63850d7b@vento.lan>
 <20170416091209.GB7456@valkosipuli.retiisi.org.uk>
 <20170419105118.72b8e284@vento.lan> <20170424093059.GA20427@amd>
 <20170424103802.00d3b554@vento.lan>
Message-ID: <20170424220701.GA27846@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Please don't add a new application under lib/. It is fine if you want
> some testing application, if the ones there aren't enough, but please
> place it under contrib/test/.
> 
> You should likely take a look at v4l2grab first, as it could have
> almost everything you would need.

I really need some kind of video output. v4l2grab is not useful
there. v4l2gl might be, but I don't think I have enough dependencies.

Umm, and it looks like libv4l can not automatically convert from
GRBG10.. and if it could, going through RGB24 would probably be too
slow on this device :-(.

> IMO, the above belongs to a separate processing module under
> 	lib/libv4lconvert/processing/

Is there an example using autogain/autowhitebalance from
libv4lconvert?

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170425/c41537cc/attachment.sig>
