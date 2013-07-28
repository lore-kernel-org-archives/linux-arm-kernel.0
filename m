From: broonie@kernel.org (Mark Brown)
Date: Sun, 28 Jul 2013 18:41:27 +0100
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <CAKON4OzQ8BYuP00L6Ugt-tAteTdqqh58YuMfZCWQPirkGf9XMA@mail.gmail.com>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <1416484.XDfk5G56BI@flatron> <20130728131901.GA8864@netboy>
 <2529481.u8xHuXumcd@flatron>
 <CAKON4OzReTRb5JnJE+07vNJ-uDndLfqq8ha04J7K3x=WtsZEWw@mail.gmail.com>
 <20130728153546.GB5224@netboy>
 <CAKON4OzQ8BYuP00L6Ugt-tAteTdqqh58YuMfZCWQPirkGf9XMA@mail.gmail.com>
Message-ID: <20130728174127.GB9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 28, 2013 at 11:50:19AM -0400, jonsmirl at gmail.com wrote:

> "furture proof" is much easier to say that it is to do. We've been
> messing around with the audio bindings for three years and still don't
> have a really good scheme. It is pretty easy to come up with the first
> 90% of a device tree. It is really hard to work out that last 10%.

I wouldn't say that for audio - we've got a pretty solid idea of what's
going on and little if any churn.  If some more of the subsystems that
we rely on were working well we could do a bit more but it's mostly just
extensions of where we're at now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130728/4fb8f828/attachment.sig>
