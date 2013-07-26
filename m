From: dwmw2@infradead.org (David Woodhouse)
Date: Fri, 26 Jul 2013 15:08:33 +0100
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <20130726113809.GB29916@titan.lakedaemon.net>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <CAL_JsqJQWOLC9f1igEpsgJB2X8mFDpqLDaFFRjGGVHctjWZLgQ@mail.gmail.com>
 <20130725193135.GT23879@titan.lakedaemon.net>
 <20130725231848.GJ24642@n2100.arm.linux.org.uk>
 <CAKON4OwwOnP9kbN0JqR5L+F1svTucAQvz0RDwqU+Gy9UAFwHog@mail.gmail.com>
 <20130726113809.GB29916@titan.lakedaemon.net>
Message-ID: <1374847713.14574.100.camel@i7.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-07-26 at 07:38 -0400, Jason Cooper wrote:
> > The scheme is also quite useful for new tree developers since it will
> > show them the universe of device tree attributes that have already
> > been standardized. By using comments, you could probably turn the
> > device tree documentation into the schema source files.
> 
> One more note on schema, since DT is a description of hardware, it would
> be useful to have two comments, a url to the datasheet, and a canonical
> name of the datasheet suitable for $searchengine.  Where available, of
> course.

Yes, that's a very good idea. After all, the behaviour described in (a
specific version of) the datasheet is an *implicit* part of the DT
binding. If I tell you "there is an 8390 <here>", then we damn well
ought to agree about how an 8390 behaves. And what revision of the chip
can be assumed from a given 'compatible' string.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130726/88a97073/attachment.bin>
