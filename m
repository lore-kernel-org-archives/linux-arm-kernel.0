From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Mar 2018 10:08:45 +0800
Subject: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <172d1da4-bde0-1f0c-b907-5582c31c8156@codeaurora.org>
References: <cover.1521246069.git.collinsd@codeaurora.org>
 <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
 <CAD=FV=Xz01ra=WS--vtA+dkb1H8wcw3UnFzXPS=zYWAQCPP5eg@mail.gmail.com>
 <184378e4-caf8-6ce3-e089-3690588fcb28@codeaurora.org>
 <CAD=FV=WsVDDaV-mMUvQWUomyBFCJZunKiyDt_K81_syoNhGRZQ@mail.gmail.com>
 <20180327115606.GC29239@sirena.org.uk>
 <172d1da4-bde0-1f0c-b907-5582c31c8156@codeaurora.org>
Message-ID: <20180328020845.GB29099@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2018 at 04:38:07PM -0700, David Collins wrote:
> On 03/27/2018 04:56 AM, Mark Brown wrote:

> > I didn't spot this in the code but something called "device tree mode"
> > sounds like it's going to be awfully confusing...

> As I explained in the earlier email, it makes the device tree
> configurations much simpler and less confusing/error prone.  I'd like to
> keep this concept around unless their are strong objections.

Like I say I didn't spot this in the code, I did give it a brief once
over but as Doug had spotted such extensive problems I was expecting a
resend.  It *is* setting off big alarm bells though, in general if your
individual driver is doing something weird to make life easier that's a
sign that it's doing things at the wrong level.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180328/24beeaf0/attachment.sig>
