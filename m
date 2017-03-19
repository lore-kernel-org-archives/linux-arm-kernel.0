From: nicolas@ndufresne.ca (Nicolas Dufresne)
Date: Sun, 19 Mar 2017 10:47:17 -0400
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <20170319142110.GT21222@n2100.armlinux.org.uk>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <20170318192258.GL21222@n2100.armlinux.org.uk>
 <aef6c412-5464-726b-42f6-a24b7323aa9c@mentor.com>
 <20170318204324.GM21222@n2100.armlinux.org.uk>
 <4e7f91fa-e1c4-1cbc-2542-2aaf19a35329@mentor.com>
 <20170319142110.GT21222@n2100.armlinux.org.uk>
Message-ID: <1489934837.3388.4.camel@ndufresne.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le dimanche 19 mars 2017 ? 14:21 +0000, Russell King - ARM Linux a
?crit?:
> > Can it be a point of failure?
> 
> There's a good reason why I dumped a full debug log using
> GST_DEBUG=*:9,
> analysed it for the cause of the failure, and tried several different
> pipelines, including the standard bayer2rgb plugin.
> 
> Please don't blame this on random stuff after analysis of the logs
> _and_
> reading the appropriate plugin code has shown where the problem is.?
> I
> know gstreamer can be very complex, but it's very possible to analyse
> the cause of problems and pin them down with detailed logs in
> conjunction
> with the source code.

I read your analyses with GStreamer, and it was all correct.

Nicolas
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170319/03da2d8c/attachment.sig>
