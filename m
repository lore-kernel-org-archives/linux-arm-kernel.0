From: broonie@kernel.org (Mark Brown)
Date: Sun, 28 Jul 2013 12:27:46 +0100
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <20130727173748.GA4813@netboy>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <51F168FC.9070906@wwwdotorg.org>
 <20130725182920.GA24955@e106331-lin.cambridge.arm.com>
 <20130725184834.GA8296@netboy>
 <20130725213753.GC17616@obsidianresearch.com>
 <20130726045433.GB4100@netboy>
 <20130726171524.GB28895@obsidianresearch.com>
 <20130727084825.GA4707@netboy>
 <20130727104018.GC9858@sirena.org.uk>
 <20130727173748.GA4813@netboy>
Message-ID: <20130728112746.GM9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 27, 2013 at 07:37:48PM +0200, Richard Cochran wrote:
> On Sat, Jul 27, 2013 at 11:40:18AM +0100, Mark Brown wrote:

> > We did have exactly the same discussion when the DT transition was
> > started - this isn't something that people only just realised might be
> > an issue.  There was a deliberate decision to focus on getting the
> > technology deployed to the point where it could be used as a straight
> > replacement for board files and accept that sometimes the results won't
> > be perfect and that we may need to rework as a result.

> Can you tell a bit more about this decision? When was it made? Who
> made it? How was it made public?

I honestly can't remember exactly - it was part of the discussion about
keeping the .dtb files in the kernel IIRC.  Given the timing and the
fact that I remember it it'd have been a mailing list discussion but I
couldn't point you at it without searching for a needle in a haystack,
sorry.  Perhaps there's a LWN writeup or something.

It's not the "we don't care" that you're seeing, it's more a product of
"we're not sure what we're doing yet, let's give ourselves a pass if we
mess things up while we're still learning" so it's probably buried in
some thread.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130728/4f4a3fe8/attachment.sig>
