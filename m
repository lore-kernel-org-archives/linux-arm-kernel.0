From: broonie@kernel.org (Mark Brown)
Date: Sat, 27 Jul 2013 11:40:18 +0100
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <20130727084825.GA4707@netboy>
References: <CAOesGMhJ+je8FZqeFxhAcYwU0CHYer+aGP6DA_8x3azrzfA2sw@mail.gmail.com>
 <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <51F168FC.9070906@wwwdotorg.org>
 <20130725182920.GA24955@e106331-lin.cambridge.arm.com>
 <20130725184834.GA8296@netboy>
 <20130725213753.GC17616@obsidianresearch.com>
 <20130726045433.GB4100@netboy>
 <20130726171524.GB28895@obsidianresearch.com>
 <20130727084825.GA4707@netboy>
Message-ID: <20130727104018.GC9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 10:48:26AM +0200, Richard Cochran wrote:

> [ I disagree about the "more thought" part. The current discussion,
>   coming years too late after the introduction of DT to ARM Linux, is
>   contrary evidence enough. ]

We did have exactly the same discussion when the DT transition was
started - this isn't something that people only just realised might be
an issue.  There was a deliberate decision to focus on getting the
technology deployed to the point where it could be used as a straight
replacement for board files and accept that sometimes the results won't
be perfect and that we may need to rework as a result.

To be clear the idea has always been to try for bindings that can be
stable but we didn't have the process to guarantee that and there were
substantial barriers in place to creating it while there was no critical
mass behind adoption.  What people are saying now is that we're now at a
point where it looks like those barriers can be overcome.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130727/8d414b08/attachment.sig>
