From: dwmw2@infradead.org (David Woodhouse)
Date: Fri, 26 Jul 2013 15:16:39 +0100
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <CAKON4OzrkHzUzKkULWCgiEpAtJ5gLxUm78R5ctd7p6trqq_gCA@mail.gmail.com>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <51F168FC.9070906@wwwdotorg.org>
 <20130725182920.GA24955@e106331-lin.cambridge.arm.com>
 <20130725184834.GA8296@netboy>
 <20130725213753.GC17616@obsidianresearch.com>
 <20130726080115.GA5436@netboy>
 <1374831744.2923.42.camel@shinybook.infradead.org>
 <20130726130927.GC4219@netboy>
 <20130726132709.GH29916@titan.lakedaemon.net>
 <1374846070.14574.92.camel@i7.infradead.org>
 <CAKON4OzrkHzUzKkULWCgiEpAtJ5gLxUm78R5ctd7p6trqq_gCA@mail.gmail.com>
Message-ID: <1374848199.14574.103.camel@i7.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-07-26 at 10:14 -0400, jonsmirl at gmail.com wrote:
> 
> Yes, yes - that's why the schema should be written down and used as a
> validation input to dtc. Then dtc can spit out errors for non-standard
> items. There would be two versions - the standard one and a legacy one
> that includes the standard one plus the hacks that can't be undone.
> 
> But more importantly it provides a framework for people creating new
> node definitions. Now they can't work in a vacuum and come up with
> random names and structure for everything.
> 
> Most of the problems express in the thread would go away if the schema
> was written down and discussed. The rule going forward would be no new
> nodes that aren't part of the standard schema.

Yes, that seems eminently sensible.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5745 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130726/27cb750a/attachment.bin>
